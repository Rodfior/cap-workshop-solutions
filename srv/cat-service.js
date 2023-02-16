const cds = require('@sap/cds')

class CatalogService extends cds.ApplicationService {
    async init() {
        const { Books, Authors } = this.entities

        this.after('READ', Books, each => {
            if (each.stock < 20) each.title += ' (only a few left!)'
        })

        this.on('totalStock', async () => {
            const query = SELECT`SUM(stock) as stock`.from(Books)
            return await cds.run(query)
        })

        this.on('submitOrder', async req => {
            const { book, quantity } = req.data

            if (quantity < 1)
                return req.reject(400, 'quantity cannot be less than 1')

            const result = await SELECT.one`stock`.from(Books).where({ ID: book })
            if (result === null)
                return req.error(404, `Book #${book} doesn't exist`)

            let { stock } = result
            if (quantity > stock)
                return req.reject(409, `${quantity} exceeds the stock for book #${book}`)

            await UPDATE(Books, book).with({ stock: { '-=': quantity } })
            stock -= quantity

            return { stock }
        })

        await super.init()
    }
}
class ExternalService extends cds.ApplicationService {
    async init() {
        const { API_BP } = this.entities
        const headers = {
            'apikey': '<put your API Key here>'
        }
        const bupaSrvAPI = await cds.connect.to('API_BUSINESS_PARTNER')
        this.on('READ', API_BP, async (req) => {
            console.log('getting data from API Hub S/4HANA Sandbox System ')
            const query = req.query
            return bupaSrvAPI.send({ query, headers })
        })
    }
}
module.exports = { CatalogService, ExternalService }

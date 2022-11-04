const cds = require('@sap/cds')

class CatalogService extends cds.ApplicationService {
    async init() {
        const { Books } = this.entities

        this.after('READ', Books, each => {
            if (each.stock < 20) each.title += ' (only a few left!)'
        })

        await super.init()
    }
}

module.exports = CatalogService
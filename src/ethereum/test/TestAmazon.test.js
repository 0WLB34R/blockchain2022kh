

const TestAmazon = artifacts.require("TestAmazon");




contract("TestAmazon", accounts => {

    let instance

    beforeEach("prepare contract", async () => {
        instance = await TestAmazon.new();
    })

    // 1) [Realizar el testing solo el dueño de la tienda puede adicionar nuevos productos], [un producto debe crearse con
    // cantidad igual a cero, controlar internamente]
    it("allows only the owner to add an item", async () => {
        try {
            await instance.addProduct([5, "snicker", 5, 3], { from: accounts[8] })
            assert(false)
        } catch (e) {
            //console.log(e.reason)
            assert.equal("You are not the owner.", e.reason)
        }
    })

    it("allows an item to be added", async () => {
        await instance.addProduct([5, "snicker", 5, 3], { from: accounts[0] })
        const item = await instance.listProducts.call(5)
        assert.equal(item.stock, 0)
    })
    // 2) [Realizar el testing al crear un producto el dueño debe ingresar un nombre con longitud mayor a 5 de forma
    // obligatoria]
    it("does not allow an item to be added with a name length of less than 5", async () => {
        try {
            await instance.addProduct([1, "sni", 5, 3], { from: accounts[0] })
            assert(false)
        } catch (e) {
            //console.log(e.reason)
            assert.equal("The name of product should be more than 5.", e.reason)
        }
    })

    // 3) Realizar el testing [solo el dueño] de la [tienda puede aumentar la cantidad que tiene un producto]
    it("allows only the owner to add a quantity", async () => {
        await instance.addProduct([5, "snicker", 5, 3], { from: accounts[0] })
        try {
            await instance.addQuantity(5, 3, { from: accounts[8] })
            assert(false)
        } catch (e) {
            //console.log(e.reason)
            assert.equal("You are not the owner.", e.reason)
        }
    })

    it("allows the owner to add a quantity", async () => {
        await instance.addProduct([5, "snicker", 5, 3], { from: accounts[0] })
        await instance.addQuantity(5, 3, { from: accounts[0] })
        const item = await instance.listProducts.call(5)
        // console.log(item.stock)
        assert.equal(item.stock, 3)
    })

    // 4) Realizar el testing solo el dueño puedo [cerrar la tienda]

    it("allows only the owner to close the store", async () => {
        try {
            await instance.closeOrOpenAmazon(true, { from: accounts[8] })
            assert(false)
        } catch (e) {
            //console.log(e.reason)
            assert.equal("You are not the owner.", e.reason)
        }
    })

    it("allows the owner to close the store", async () => {
        await instance.closeOrOpenAmazon(true, { from: accounts[0] })
        try {
            await instance.buyProduct(5,3, { from: accounts[8] })
            assert(false)
        } catch (e) {
            //console.log(e.reason)
            assert.equal("Amazon is closed.", e.reason)
        }
    })

// 5) Realizar el testing solo el dueño puede retirar el total ganado a su direccion de billetera
    it("allows only the owner to withdraw the balance", async () => {
        try {
            await instance.withdrawAllMoney({ from: accounts[8]})
            assert(false)
        } catch (e) {
            //console.log(e.reason)
            assert.equal("You are not the owner.", e.reason)
        }
    })

    it("allows the owner to withdraw the balance", async () => {
        await instance.addProduct([5, "snicker", 5, 3], { from: accounts[0] })
        await instance.addQuantity(5,3,{from:accounts[0]})
        await instance.buyProduct(5,1,{from:accounts[8], value: web3.utils.toWei("3","ether")})
        await instance.withdrawAllMoney({from: accounts[0]})
        const finalBalance = await web3.eth.getBalance(instance.address);
        assert.equal(finalBalance,0)

    })

    // 6) Realizar el testing el cliente puede comprar de 1 a N productos (hacer el calculo correspondiente segun el
    // precio unitario del producto) verificar el descuento a la wallet del cliente, quantity del producto y el balance del
    // smart contract

    it("allows the client to buy a product", async () =>{
        const quantityToBuy = 2
        await instance.addProduct([5, "snicker", 5, 3], { from: accounts[0] })
        await instance.addQuantity(5,3,{from:accounts[0]})
        const initialBalance = await web3.eth.getBalance(accounts[8])
        await instance.buyProduct(5,quantityToBuy,{from:accounts[8], value: web3.utils.toWei("6","ether")})
        const item = await instance.listProducts.call(5)
        const balance = await web3.eth.getBalance(instance.address)
        const newBalance = parseFloat(initialBalance)-web3.utils.toWei("6","ether")
        //descuento
        assert( initialBalance > newBalance)
        //quantity del producto
        assert.equal(item.stock,1)
        //balance del smart contract
        assert.equal(balance,web3.utils.toWei("6","ether"))
    })

    // 7) Realizar el testing el cliente puede comprar de 1 a N productos (hacer el calculo correspondiente segun el
    // precio unitario del producto) controlar internamente si existe el stock suficiente para comprar el producto
    it("does not allow the client to buy a product if there is no stock", async () =>{
        const quantityToBuy = 50
        await instance.addProduct([5, "snicker", 5, 1], { from: accounts[0] })
        await instance.addQuantity(5,3,{from:accounts[0]})
        try{
        await instance.buyProduct(5,quantityToBuy,{from:accounts[8], value: web3.utils.toWei("150","ether")})
        assert(false)
        }catch (e){
            assert.equal("There is not the stock in product.", e.reason)
        }
    })

    // 8) Realizar el testing de si el cliente compra mas de 10 productos de un solo tipo se le realiza un descuento del
    // precio de uno

    it("allows the client to buy a product with a discount", async () =>{
        const quantityToBuy = 11
        await instance.addProduct([5, "snicker", 5, 1], { from: accounts[0] })
        await instance.addQuantity(5,200,{from:accounts[0]})
        await instance.buyProduct(5,quantityToBuy,{from:accounts[5], value: web3.utils.toWei("11","ether")})
        const balance = await web3.eth.getBalance(instance.address)
        assert.equal(balance,10999999999999999999)
    })

})
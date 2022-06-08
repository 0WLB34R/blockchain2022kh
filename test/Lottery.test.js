const Lottery = artifacts.require("Lottery");

contract("Lottery", accounts => {

    let instance

    beforeEach("deploy a contract", async () => {
        instance = await Lottery.new();
    })

    it("allow one account to enter", async () =>{

        await instance.enter({from: accounts[1], value: web3.utils.toWei("3","ether")})

        const players = await instance.getPlayers.call();
        
        assert.equal(accounts[1],players[0])
        assert.equal(1, players.length)
    })

    it("allow entry to multiple accounts", async () =>{

        await instance.enter({from: accounts[0], value: web3.utils.toWei("3","ether")})
        await instance.enter({from: accounts[1], value: web3.utils.toWei("3","ether")})
        await instance.enter({from: accounts[2], value: web3.utils.toWei("3","ether")})

        const players = await instance.getPlayers.call();

        assert.equal(accounts[0],players[0])
        assert.equal(accounts[1],players[1])
        assert.equal(accounts[2],players[2])
        assert.equal(3, players.length)
    })

})

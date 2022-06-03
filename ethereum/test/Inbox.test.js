const Inbox = artifacts.require('Inbox')

contract("Inbox", accounts =>{
    it('getMessage', async () =>{
        const instance = await Inbox.deployed();
        const message = await instance.getMessage.call();
        assert.equal(message,"Hi");

    });

    it('setMessage should change var', async () => {
        const instance = await Inbox.deployed();
        await instance.setMessage('Hi Ken',{from: accounts[0]});
        const message = await instance.getMessage.call();
        assert.equal(message,'Hi Ken')
    })

    it('setMessage should not change', async ()=>{
       try{
        const instance = await Inbox.deployed();
        await instance.setMessage('Hi not Ken',{from: accounts[1]});
       }catch (e){
        console.log('error',e);
        assert.equal(e.reason,'Has to be the owner')
       }
    })
})
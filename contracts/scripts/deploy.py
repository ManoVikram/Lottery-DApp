from brownie import accounts, Lottery

def deploy():
    account = accounts[0]
    Lottery.deploy({"from": account})

def main():
    deploy()
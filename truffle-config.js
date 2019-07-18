const ProviderEngine = require("web3-provider-engine")
const RpcProvider = require("web3-provider-engine/subproviders/rpc.js")
const { TruffleArtifactAdapter, RevertTraceSubprovider } = require("@0x/sol-trace")
const { GanacheSubprovider } = require("@0x/subproviders")
const { ProfilerSubprovider } = require("@0x/sol-profiler")
const { CoverageSubprovider } = require("@0x/sol-coverage")

const mode = process.env.MODE

const projectRoot = ""
const solcVersion = "0.5.10"
const defaultFromAddress = "0x5409ed021d9299bf6814279a6a1411a7e866a631"
const isVerbose = true
const artifactAdapter = new TruffleArtifactAdapter(projectRoot, solcVersion)
const provider = new ProviderEngine()

if (mode === "profile") {
  global.profilerSubprovider = new ProfilerSubprovider(
    artifactAdapter,
    defaultFromAddress,
    isVerbose
  )
  global.profilerSubprovider.stop()
  provider.addProvider(global.profilerSubprovider)
} else {

  if (mode === "coverage") {
    global.coverageSubprovider = new CoverageSubprovider(
      artifactAdapter,
      defaultFromAddress,
      {
        isVerbose,
      }
    )
    provider.addProvider(global.coverageSubprovider)
  } else if (mode === "trace") {
    const revertTraceSubprovider = new RevertTraceSubprovider(
      artifactAdapter,
      defaultFromAddress,
      isVerbose
    )
    provider.addProvider(revertTraceSubprovider)
  }

  provider.addProvider(new RpcProvider({ rpcUrl: "http://localhost:8545" }))
  // const ganacheSubprovider = new GanacheSubprovider()
  // provider.addProvider(ganacheSubprovider)
}

provider.start(err => {
  if (err) {
    console.error(err)
    process.exit(1)
  }
})
/**
 * HACK: Truffle providers should have `send` function, while `ProviderEngine` creates providers with `sendAsync`,
 * but it can be easily fixed by assigning `sendAsync` to `send`.
 */
provider.send = provider.sendAsync.bind(provider)

module.exports = {
  networks: {
    development: {
      provider,
      network_id: "*"
    },
    test: {
      provider,
      network_id: "*"
    }
  },

  mocha: {
    reporter: 'eth-gas-reporter',
    reporterOptions : {
      currency: 'USD',
      gasPrice: 1
    },
    timeout: 100000,
  },

  compilers: {
    solc: {
      version: solcVersion,
    }
  }
}

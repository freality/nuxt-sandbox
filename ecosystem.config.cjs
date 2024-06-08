module.exports = {
  apps: [
    {
      name: 'NuxtSandbox',
      port: '3000',
      exec_mode: 'cluster',
      instances: 'max',
      script: '/app/server/index.mjs',
    },
  ],
}

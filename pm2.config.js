module.exports = {
  apps: [
    {
      name: 'hydro-web',
      script: 'hydroo',
      args: 'start',
      env: {
        PORT: 10000,
        // 非常重要：在非 root 容器中运行，必须关闭沙箱保护，让评测机在本地环境直接运行评测
        HYDRO_SANDBOX: 'none'
      }
    }
  ]
};

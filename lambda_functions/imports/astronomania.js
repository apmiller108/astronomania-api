exports.runImports = function(event, context, callback) {
  let fetch = require('node-fetch');

  const environments = {
    staging: {
      url: 'https://astronomania-api-staging.herokuapp.com/',
      email: 'scheduler@astronomania.co',
      password: process.env.STAGING_PASSWORD
    },
    production: {
      url: 'https://astronomania-api-production.herokuapp.com/',
      email: 'scheduler@astronomania.co',
      password: process.env.PRODUCTION_PASSWORD
    }
  };

  Object.keys(environments).forEach((key) => {
    let env = environments[key];
    let authBody = {
      authenticate: {
        email: env.email,
        password: env.password
      }
    };
    let authOptions = {
      method: 'POST',
      body: JSON.stringify(authBody),
      headers: { 'Content-Type': 'application/json' }
    };

    let startImportJob = function(authToken) {
      let options = {
        method: 'POST',
        body: JSON.stringify({
          job: {
            job_type: 'import'
          }
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + authToken
        }
      };
      fetch(env.url + '/admin/jobs', options)
        .then((res) => console.log(res.status));
    };

    fetch(env.url + '/users/login', authOptions)
      .then((res) => res.json())
      .then((json) => {
        startImportJob(json.auth_token);
      })
      .catch((err) => console.log(err));
  });
};

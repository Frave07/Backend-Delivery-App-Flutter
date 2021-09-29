import http from './App';


http.listen( process.env.APP_PORT, () => console.log('Server on port ' + process.env.APP_PORT));
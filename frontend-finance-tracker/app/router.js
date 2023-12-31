import EmberRouter from '@ember/routing/router';
import config from 'frontend-finance-tracker/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('index');

  this.route('login');

  this.route('authenticated', { path: '' }, function () {
    this.route('admin', function () {
      this.route('roles');
      this.route('accountroles');
    });
    this.route('settings');
    this.route('add-expense');
    this.route('expenses');
    this.route('stats');
  });

  this.route('permission-denied');
  this.route('404', { path: '/*path' });
});

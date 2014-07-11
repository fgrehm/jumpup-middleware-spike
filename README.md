### Spike on rewriting [jumpup](https://github.com/Helabs/jumpup) projects to use middlewares

Inspired by http://johnbender.us/2012/04/28/middleware-as-a-general-purpose-abstraction
and with some code from https://github.com/mitchellh/middleware

#### TODO

- [x] Initial setup (rspec, guard, ...)
- [x] Jumpup::Builder
- [x] Jumpup::Runner
- [ ] Jumpup::Config
- [ ] Jumpup::UI
- [ ] Prototype on current `rake integrate` functionality
- [ ] Rake tasks
- [ ] Support for plugins by injecting middlewares at specific points of the stack
- [ ] Support for things like integration with capistrano

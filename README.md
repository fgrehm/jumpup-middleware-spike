# jumpup-middleware-spike

This is an ugly spike on rewriting [jumpup](https://github.com/Helabs/jumpup) projects to use middlewares

Inspired by http://johnbender.us/2012/04/28/middleware-as-a-general-purpose-abstraction and with some code from https://github.com/mitchellh/middleware

## TODO

- [x] Initial setup (rspec, guard, ...)
- [x] Jumpup::Builder
- [x] Jumpup::Runner
- [x] Prototype on current `rake integrate` functionality
- [x] Support for plugins by injecting middlewares at specific points of the stack
- [ ] Make plugin hooking more robust (inserting things at specific points of the stack is not robust, look into vagrant for inspiration)
- [ ] Jumpup::Config
- [ ] Jumpup::UI
- [ ] Make this a gem and test with real projects
- [ ] Rake tasks
- [ ] Support for things like integration with capistrano (?)
- [ ] Nicely handle interrupts

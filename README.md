#FlameGraph for Java - An Easy way to quickly create flamegraphs for Java.

#Installation
```npm install javaflamegraph```

#Usage
1. ```cd ./node_modules/javaflamegraph```
2. ```npm start``` - This will wait till it detects a process with name 'Java'. Can be best best used to start profiling at program startup.
3. ```npm run start <process id>``` - This will start profiling for the given process id.
    e.g. ```npm run start 1234```

#Dependency
This library depends on perl, shell, and jstack (Java SDK).These are already available on linux/mac.On windows you can use this package with cygwin.

##Acknowledgements
Thanks to [Brendan Gregg's FlameGraph](https://github.com/brendangregg/FlameGraph)

## License

MIT © [Saquib Khan](https://github.com/saquibkhan)

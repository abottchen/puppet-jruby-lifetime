# puppet-jruby-lifetime

```
Usage: jruby-lifetime.rb files...
```

Parses the list of puppetserver files provided looking for JRuby create and flush events.  Outputs the min, max, and average lifetime of JRubies flushed over the course of the logs provided.

Example:

```bash
 # ~/projects/jruby-lifetime/jruby_lifetime.rb puppetserver-2018-01-09.*
 Processing puppetserver-2018-01-09.0.log
 Processing puppetserver-2018-01-09.1.log
 308.0 - Created at 2018-01-09 02:14:12 and destroyed at 2018-01-09 09:54:07, delta=07:39:55
 304.0 - Created at 2018-01-09 01:15:32 and destroyed at 2018-01-09 09:54:07, delta=08:38:35
 301.0 - Created at 2018-01-09 03:23:15 and destroyed at 2018-01-09 09:54:07, delta=06:30:52
 303.0 - Created at 2018-01-09 04:39:12 and destroyed at 2018-01-09 09:54:07, delta=05:14:55
 310.0 - Created at 2018-01-09 05:43:12 and destroyed at 2018-01-09 09:54:07, delta=04:10:55
 302.0 - Created at 2018-01-09 08:32:18 and destroyed at 2018-01-09 09:54:07, delta=01:21:49
 311.0 - Created at 2018-01-09 07:17:52 and destroyed at 2018-01-09 09:54:07, delta=02:36:15
 307.0 - Created at 2018-01-09 06:24:43 and destroyed at 2018-01-09 09:54:07, delta=03:29:24
 Longest uptime: 08:38:35  shortest uptime: 01:21:49  average: 04:57:50
```

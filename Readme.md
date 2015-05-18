# Docker ASP.NET Development Image

Image built with everything required to use as a development container

#### Docker URL

(https://registry.hub.docker.com/u/benhall/aspnet-vnext-npm/)[https://registry.hub.docker.com/u/benhall/aspnet-vnext-npm/]


#### Example

`docker run -it -v $(pwd)/.dnx:/home/dev/.dnx -v $(pwd)/WebApplication:/app -w="/app" -p 5004 benhall/aspnet-vnext-npm dnx . kestrel`



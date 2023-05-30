# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

WORKDIR /src

COPY src/*.csproj .

RUN dotnet restore

COPY src .

RUN dotnet publish -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

WORKDIR /publish

COPY --from=build-env /publish .

EXPOSE 80

ENTRYPOINT ["dotnet","myWebApp.dll"]
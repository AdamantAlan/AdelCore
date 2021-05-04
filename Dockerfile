FROM mcr.microsoft.com/dotnet/sdk:5.0 as dotnet
ENV ASPNETCORE_URLS=http://+:901  
WORKDIR /app
COPY ./AdelCore/*.csproj ./
RUN dotnet restore
COPY . ./
RUN dotnet publish -c Release -o out
FROM mcr.microsoft.com/dotnet/sdk:5.0
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:901  
COPY --from=dotnet /app/out .
ENTRYPOINT ["dotnet","AdelCore.dll"]
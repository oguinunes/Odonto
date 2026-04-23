# Estágio de Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia e restaura
COPY *.csproj ./
RUN dotnet restore

# Copia tudo e publica
COPY . ./
RUN dotnet publish -c Release -o out

# Estágio de Execução
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Porta padrão do ASP.NET
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

ENTRYPOINT ["dotnet", "Pi_Odonto.dll"]
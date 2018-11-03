# liquigen

Comparing with ruby, java sucks.

It is a simple tool for java liquibase script generation.

Only support mysql db and create_table currently. And it is not a perfect tool, only help to create basic content with simple name. Please change the generated content manually.

## how to use
1. Add **.ruby-version** to your java project directory. Fill the ruby version as the content, say, 2.5.1.

2. Add **.Gemfile** to the same directory.

``` ruby
source 'https://rubygems.org'

gem 'liquigen'

```
3. bundle install

4. Use the script to create database script.

## create_table

```bash
liquigen create_table -t table_name prop1:type prop2:type

# Example
liquigen create_table -t user id:integer name:string email:string created_time:datetime updated_time:datetime
```
The result file:
```yaml
databaseChangeLog:
- changeSet:
    id: '20181103214403'
    name: jeremy
    changes:
    - createTable:
        tableName: users
        columns:
        - column:
            name: id
            type: bigint
            constraints:
            - constraint:
                primaryKey: true
            autoIncrement: true
        - column:
            name: name
            type: varchar(255)
            constraints:
            - constraint:
                nullable: false

```

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/jerecui/liquigen.

License
The gem is available as open source under the terms of the MIT License.
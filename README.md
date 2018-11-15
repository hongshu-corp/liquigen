# liquigen

Comparing with ruby, java sucks.

It is a simple tool for java liquibase script generation.

Only support mysql db and create_table currently. And it is not a perfect tool, only help to create basic content with simple name. Please change the generated content manually.

## how to use
1. gem install liquigen

2. Use the liquigen script. For help, type

```bash
liquigen help
```

## create_table

```bash
liquigen add_table -t table_name prop1:type prop2:type

# Example
liquigen add_table -t user id:integer name:string email:string created_time:datetime updated_time:datetime
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

## modify_table

ToDo.

## drop table

ToDo.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/jerecui/liquigen.

License
The gem is available as open source under the terms of the MIT License.
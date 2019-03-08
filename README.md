# liquigen

Comparing with ruby, java sucks.

It is a simple tool for java liquibase script generation.

Only support mysql db. And it is not a perfect tool, can help to create basic content with simple name. Please change the generated content manually if the generation was wrong.

[Liquibase documentation](http://www.liquibase.org/documentation/changes/).

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
                primaryKey: true
            autoIncrement: true
        - column:
            name: name
            type: varchar(255)
            constraints:
                nullable: false

```

## rename_table
```bash
liquigen rename_table users:s_users customers:s_customers
```

Result file:
```yaml
databaseChangeLog:
- changeSet:
    id: 20181121150900_RenameTableUsersAndCustomer
    author: Jeremy
    changes:
    - renameTable:
        oldTableName: users
        newTableName: s_users
    - renameTable:
        oldTableName: customers
        newTableName: s_customers

```

## drop_table
```bash
liquigen drop_table user customer
```

## add_column
```bash
liquigen add_column -t users name:string email:string
```

Result:
```yaml
databaseChangeLog:
- changeSet:
    id: 20181121155512_AddColumn_User_NameAndEmail
    author: Jeremy Cui
    changes:
    - addColumn:
        tableName: users
        columns:
        - column:
            name: name
            type: varchar(255)
            constraints:
                nullable: false
        - column:
            name: email
            type: varchar(255)
            constraints:
                nullable: false

```

## rename_column
```bash
liquigen rename_column user:status:status_ok:string customer:status:status_ok:string
```

Result:
```yaml
databaseChangeLog:
- changeSet:
    id: 20181121162306_RenameColumn_UserStatusToStatusOkAndCustomerStatusToStatusOk
    author: Jeremy Cui
    changes:
    - renameColumn:
        tableName: users
        oldColumnName: status
        newColumnName: status_ok
        columnDataType: varchar(255)
    - renameColumn:
        tableName: customers
        oldColumnName: status
        newColumnName: status_ok
        columnDataType: varchar(255)

```

## change_type
```bash
liquigen change_type user:id:integer customer:name:string
```

Result:
```yaml
databaseChangeLog:
- changeSet:
    id: '20181121145051'
    author: Jeremy
    changes:
    - modifyDataType:
        tableName: users
        columnName: id
        newDateType: bigint
    - modifyDataType:
        tableName: customers
        columnName: name
        newDateType: varchar(255)

```

## create_index
```bash
liquigen add_index -t user name:string email:string
```

## sql
```bash
liquigen sql "update users set column=true" "update customers set x = 1"
```

## config
Which is used for scaffolding java codes. In your application directory, one file called '.liquigen' will be added.
```bash
liquigen config
```

Please specify your custom name and path:
* package_name=com.yourpackage
* java_codes_root=src/main/java
* migration_path=src/main/resources/db/migrations
* controller_package_name=
* entity_package_name=
* repository_package_name=

## scaffold
```bash
liquigen scaffold -t table --controller --repository id:integer name:string email:string
# Get help by typing liquigen scaffold --help
```

## How to let the liquibase use migration directory

* In your java project, open application.yml, add the following lines:
```yaml
spring:
  liquibase:
    change-log: classpath:/db/changelog-master.yaml
    relativeToChangelogFile: true
```
* Edit your changelog-master.yaml file.
```yaml
databaseChangeLog:
- includeAll:
    path: "db/migrations/"
```

That's it.
* Liquigen will create the directory automatically.


## How to use the latest source in your java project

1. Add .ruby-version file to your project root path.

```ruby
ruby-2.5.1

```
You can also use the other version.

2. Add Gemfile file as well.
```ruby
source 'https://rubygems.org'

gem 'liquigen', :git => 'https://github.com/jerecui/liquigen'
```
3. Bundle install

```sh
bundle install

```
4. cd your project in command line, type liquigen xxxxx

```sh
# say
liquigen add_table -t user id:integer name:string
```


## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/jerecui/liquigen.

License
The gem is available as open source under the terms of the MIT License.
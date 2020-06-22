# Flexible Communication Protocol

## 约定字

- 约定字将继续存在并加强重要性
- 复合结构约定字现在同样可拥有`_type`
- 复合结构约定字默认同样为列表结构
- 新的系统约定字
  - `_type` 类型描述 *string*
  - `_id` ID
  - `_union` 关联数据
  - `_code` 发起请求时的通讯编码 *string(8)* `/`*通常*
    - 建议8字节内
    - 映射Http Method
  - `_result` 返回响应时的结果状态 *integer* `/`*通常*
    - 约定LSP保留号段`[1000, 9999]`
    - 约定用户自定义号段`[10000, 2^23-1]`，即3字节首位0
  - `_message` 消息体 `/`*通常*
  - `_meta` 结构描述 `/`*通常*
    - 在使用压缩数据结构时才启用
  - `_refs` 引用 *string*
    - 以`.`分隔的字串描述引用的数据路径

### 引用的范例

```json
{
  "user": [
    {
      "_refs": "me.0",
    }
  ],
  "me": [
    {
      "name": "Triss",
      "pass": "123456",
      "age":  42,
      "_type": "user",
      "_id": 1,
    }
  ]
}
```

## 修饰器

- 目前概念基本不变
- 复合字段仍然默认列表结构

## 操作符

概念转换为 **在`某个环境`下基于`某个数据`调用`某个操作`并给予`相关参数`并`返回结果`**

### 结构解析

- 某个环境称为`context`
- 某个数据称为`binding`
- 某个操作称为`handler`
- 相关参数称为`identifier`
  - 标准结构为`<endpoint>./<id>?<query>`
  - `endpoint`是由`/`分隔可递归解析的字串
  - `id`是由`/`分隔的若干个id
    - 当不存在`id`时，`endpoint`不需要以`./`结尾
  - `query`是web标准的键值结构
    - 不存在前两者时，也可以单纯描述query：`?var1=1&var2=2`
- 返回结果称为`result`

> `./`中的`.`在`identifier`声明时是必填的，在引用时可以省略只写`/`

### Identifier的数组结构

可以以数组对象的形式描述，结构范例

```json
[
  // endpoint
  [
    "a",
    "b",
    "c"
  ],
  // id
  [
    1,
    2
  ],
  // query
  {
    "field1": 10,
    "field2": 20
  }
  // 末尾保留scheme支持
]
```

## 压缩数据

压缩前：

```json
{
  "user": [
    {
      "name": "Triss",
      "pass": "123456",
      "age":  42,
      "_type": "user",
      "_id": 1
    },
    {
      "name": "Tom",
      "pass": "654321",
      "age":  36,
      "_type": "user",
      "_id": 2
    }
  ]
}
```

压缩后：

```json
{
  "user": [
    [
      "Triss",
      "123456",
      42
      "user",
      1
    ],
    [
      "Tom",
      "654321",
      36
      "user",
      2
    ]
  ],
  "_meta": [
    [
      "source": "user.*",
      "fields": [
        "name",
        "pass",
        "age",
        "_type",
        "_id",
      ],
    ]
  ]
}
```

> 支持按根域进行压缩

## 请求关系映射

上行发起请求时，支持多种基础协议及表达方式。

例如`GET https://mydomain.com/api/user/1?included=contract,intro`可解为：

```json
{
  "_code": "GET",
  "$api": "//mydomain.com/api/user/1?included=contract,intro"
}
```

或

```json
{
  "_code": "GET",
  "$api": [
    [
      "mydomain.com",
      "api",
      "user"
    ],
    [
      1
    ],
    {
      "included": "contract,intro"
    }
  ]
}
```

> `scheme`预留在操作符第4存储位

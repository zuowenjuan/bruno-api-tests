\# 获取学生列表接口测试用例 (GET /api/students)



接口信息

| 项目 | 内容 |

| URL | /api/students |

| 方法 | GET |

| 认证 | 可选（是否需要token视业务而定） |

| 参数 | page（页码，默认1）、limit（每页条数，默认10）



测试用例

正向用例（Happy Path）

TC-STU-01: 正常获取学生列表（无参数）

| 字段 | 内容 |

| 测试点 | 不传任何参数，获取默认的学生列表 |

| 输入 | 无参数 |   | 预期状态码 | 200 |

| 预期响应体 | 返回数组，`data` 不为空 |

| 预期断言 | `res.status === 200` 

&#x20;`Array.isArray(res.body)` 为 true 

`res.body.length > 0` |



TC-STU-02: 获取学生列表（带分页参数）   

| 字段 | 内容 |

| 测试点 | 带 page 和 limit 参数获取分页数据 |   

| 输入 | `?page=1\&limit=5` |   

| 预期状态码 | 200 |   

| 预期响应体 | 返回 5 条数据 |   

| 预期断言 | `res.body.length === 5` |     



&#x20;TC-STU-03: 获取第二页数据   

| 字段 | 内容 | 

| 测试点 | 获取第2页数据 |   

| 输入 | `?page=2\&limit=5` |   

| 预期状态码 | 200 |   

| 预期断言 | 返回的数据与第1页不同 |     



TC-STU-04: 验证返回字段完整性   

| 字段 | 内容 | 

| 测试点 | 验证每条学生记录包含必要字段 |   

| 输入 | 无参数 |   | 预期状态码 | 200 |   

| 预期断言 | 每条记录包含 `student\_id`、`name`、`class`、`gender`、`birth\_date` |



边界值测试  

TC-STU-05: limit 为最小值（1）   

| 字段 | 内容 |  

| 测试点 | 每页返回1条数据 |   

| 输入 | `?page=1\&limit=1` |   

| 预期状态码 | 200 |   

| 预期断言 | `res.body.length === 1` |     



TC-STU-06: limit 为最大值（100）   

| 字段 | 内容 | 

| 测试点 | 每页返回100条数据（如果数据够） |   

| 输入 | `?page=1\&limit=100` |   

| 预期状态码 | 200 |   

| 预期断言 | `res.body.length <= 100` |  



&#x20;TC-STU-07: page 超出最大页数   

| 字段 | 内容 | 

| 测试点 | 请求的页码超过总页数 |   

| 输入 | `?page=999` |   | 预期状态码 | 200 |   

| 预期响应体 | 返回空数组 |   

| 预期断言 | `res.body.length === 0` |



异常用例 - 参数错误

TC-STU-08: limit 为 0   

| 字段 | 内容 |  

| 测试点 | limit 传0（无效值） |   

| 输入 | `?page=1\&limit=0` |   

| 预期状态码 | 400 |   

| 预期响应体 | 提示 limit 必须大于0 |  



TC-STU-09: page 为负数   

| 字段 | 内容 |  

| 测试点 | page 传负数 |   

| 输入 | `?page=-1` |   

| 预期状态码 | 400 |   

| 预期响应体 | 提示 page 必须为正整数 |   



&#x20;TC-STU-10: limit 为负数   

| 字段 | 内容 |   

|:---|:---|   | 测试点 | limit 传负数 |   

| 输入 | `?limit=-5` |   | 预期状态码 | 400 |   

| 预期响应体 | 提示 limit 必须为正整数 |



&#x20;TC-STU-11: limit 为非数字   

| 字段 | 内容 |   |:---|:---|   

| 测试点 | limit 传非数字字符串 |   

| 输入 | `?limit=abc` |

| 预期状态码 | 400 |



TC-STU-12: page 为非数字

| 字段 | 内容 |

| 测试点 | page 传非数字字符串 |

| 输入 | `?page=abc` |

| 预期状态码 | 400 |



测试用例统计

| 类型 | 数量 | 用例编号 |   |:---|:---|:---|

| 正向用例 | 4 | STU-01, STU-02, STU-03, STU-04 |

| 边界值测试 | 3 | STU-05, STU-06, STU-07 |

| 异常参数 | 3 | STU-08, STU-09, STU-10 |

| \*\*合计\*\* | \*\*10\*\* | 



断言示例（Bruno）

TC-STU-01: 正常获取列表

test('状态码200', () => expect(res.status).to.equal(200));

test('返回数组', () => expect(res.body).to.be.an('array'));

test('数组不为空', () => expect(res.body.length).to.be.above(0));



&#x20;TC-STU-04: 字段完整性

test('包含student\_id', () => expect(res.body\[0]).to.have.property('student\_id'));

test('包含name', () => expect(res.body\[0]).to.have.property('name'));

test('包含class', () => expect(res.body\[0]).to.have.property('class'));



TC-STU-07: 空页面   

test('返回空数组', () => expect(res.body.length).to.equal(0));






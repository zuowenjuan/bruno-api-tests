\# 创建学生接口测试用例 (POST /api/students)      



\## 接口信息   

| 项目 | 内容 |  

| URL | /api/students |   

| 方法 | POST |   

| Content-Type | application/json |   

| 认证 | 需要（通常需要管理员权限） |   

| 请求体 | `{ "name": "string", "class": "string", "gender": "Male/Female", "birth\_date": "YYYY-MM-DD" }` |  



测试用例



正向用例（Happy Path）

TC-STU-CREATE-01: 正常创建学生（所有字段完整）   

| 字段 | 内容 |

| 测试点 | 提供所有必填字段，成功创建学生 |   

| 输入 | `{"name": "张三", "class": "三班", "gender": "Male", "birth\_date": "2005-03-15"}` |   

| 预期状态码 | 201 |   

| 预期响应体 | 返回新创建的学生 ID |   

| 预期断言 | `res.status === 201` <br> `res.body` 包含 `student\_id` 或 `id` |     



TC-STU-CREATE-02: 只提供必填字段（name + class）   

| 字段 | 内容 |

| 测试点 | 只提供 name 和 class，其他字段用默认值 |   

| 输入 | `{"name": "李四", "class": "四班"}` |   

| 预期状态码 | 201 |   

| 预期断言 | 创建成功，其他字段为 null 或默认值 |   



TC-STU-CREATE-03: 创建女生（gender=Female）   

| 字段 | 内容 |

| 测试点 | 创建性别为女的学生 |   

| 输入 | `{"name": "王芳", "class": "三班", "gender": "Female"}` |   

| 预期状态码 | 201 |   

| 预期断言 | `res.status === 201`，数据库中 gender 为 Female |    



边界值测试    

TC-STU-CREATE-04: name 为最小长度（1个字符）   

| 字段 | 内容 | 

| 测试点 | 姓名只有1个字符 |   

| 输入 | `{"name": "张", "class": "三班"}` |   

| 预期状态码 | 201 |   

| 预期断言 | 创建成功 |   



TC-STU-CREATE-05: name 为最大长度（50个字符）   

| 字段 | 内容 |  

| 测试点 | 姓名达到数据库限制的最大长度 |   

| 输入 | `{"name": "（50个字的姓名）", "class": "三班"}` |   

| 预期状态码 | 201 |   

| 预期断言 | 创建成功 |    



TC-STU-CREATE-06: birth\_date 为边界值（2000-01-01）   

| 字段 | 内容 |  

| 测试点 | 出生日期为2000年1月1日 |   

| 输入 | `{"name": "赵六", "class": "三班", "birth\_date": "2000-01-01"}` |   

| 预期状态码 | 201 |   

| 预期断言 | 创建成功 |     



异常用例 - 参数缺失/格式错误  

TC-STU-CREATE-07: 缺少必填字段 name   

| 字段 | 内容 |  

| 测试点 | 请求体中没有 name 字段 |   

| 输入 | `{"class": "三班"}` |   

| 预期状态码 | 400 |   

| 预期响应体 | `{"code": 400, "message": "name 不能为空"}` |  



&#x20;TC-STU-CREATE-08: 缺少必填字段 class   

| 字段 | 内容 |   

| 测试点 | 请求体中没有 class 字段 |   

| 输入 | `{"name": "张三"}` |   

| 预期状态码 | 400 |   



TC-STU-CREATE-09: name 为空字符串   

| 字段 | 内容 |  

| 测试点 | name 传空字符串 |   

| 输入 | `{"name": "", "class": "三班"}` |   

| 预期状态码 | 400 |   

| 预期响应体 | 提示 name 不能为空 |  



TC-STU-CREATE-10: class 为空字符串   

| 字段 | 内容 | 

| 测试点 | class 传空字符串 |   

| 输入 | `{"name": "张三", "class": ""}` |   

| 预期状态码 | 400 |   



补充用例（参数格式错误）   

TC-STU-CREATE-11: gender 不是枚举值   

| 字段 | 内容 | 

| 测试点 | gender 传了不在枚举中的值 |   

| 输入 | `{"name": "张三", "class": "三班", "gender": "Other"}` |   

| 预期状态码 | 400 |   

| 预期响应体 | 提示 gender 必须是 Male 或 Female |  



TC-STU-CREATE-12: birth\_date 格式错误   

| 字段 | 内容 | 

| 测试点 | 出生日期格式不正确 |   

| 输入 | `{"name": "张三", "class": "三班", "birth\_date": "2025/03/15"}` |   

| 预期状态码 | 400 |    



TC-STU-CREATE-13: name 超长   

| 字段 | 内容 |  

| 测试点 | name 超过数据库字段长度限制 |   

| 输入 | `{"name": "（51个字的姓名）", "class": "三班"}` |   

| 预期状态码 | 400 |   



&#x20;TC-STU-CREATE-14: 重复创建（相同 name + class）   

| 字段 | 内容 |  

| 测试点 | 创建已存在的学生（如果业务不允许重复） |   

| 前置条件 | 已有学生 "张三" 在 "三班" |   

| 输入 | `{"name": "张三", "class": "三班"}` |   

| 预期状态码 | 409 |   

| 预期响应体 | `{"code": 409, "message": "学生已存在"}` |   



&#x20;TC-STU-CREATE-15: 请求体为 null   

| 字段 | 内容 | 

| 测试点 | 请求体为空或 null |   

| 输入 | `null` |   | 预期状态码 | 400 |   



&#x20;TC-STU-CREATE-16: 请求体为数组   

| 字段 | 内容 | 

| 测试点 | 传入数组而非对象 |   

| 输入 | `\[{"name": "张三", "class": "三班"}]` |   

| 预期状态码 | 400 |   



&#x20;测试用例统计      

| 类型 | 数量 | 用例编号 |

| 正向用例 | 3 | CREATE-01, CREATE-02, CREATE-03 |   

| 边界值测试 | 3 | CREATE-04, CREATE-05, CREATE-06 |   

| 参数缺失 | 4 | CREATE-07, CREATE-08, CREATE-09, CREATE-10 |   

| 参数格式错误 | 3 | CREATE-11, CREATE-12, CREATE-13 |   

| 业务冲突 | 1 | CREATE-14 |   

| 请求体格式错误 | 2 | CREATE-15, CREATE-16 |   

| \*\*合计\*\* | \*\*16\*\* |



&#x20;断言示例（Bruno）

&#x20;TC-STU-CREATE-01: 正常创建   

test('状态码201', () => expect(res.status).to.equal(201));   

test('返回了student\_id', () => expect(res.body).to.have.property('student\_id'));   

test('student\_id是数字', () => expect(res.body.student\_id).to.be.a('number'));     



&#x20;TC-STU-CREATE-07: 缺少name   

test('状态码400', () => expect(res.status).to.equal(400));   

test('返回错误码', () => expect(res.body).to.have.property('code'));   

test('错误码是400', () => expect(res.body.code).to.equal(400));   

test('错误信息包含name', () => expect(res.body.message).to.include('name'));



TC-STU-CREATE-14: 重复创建   

test('状态码409', () => expect(res.status).to.equal(409));   

test('返回冲突信息', () => expect(res.body.message).to.include('已存在'));






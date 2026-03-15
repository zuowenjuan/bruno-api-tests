\# 用户管理 API 自动化测试框架



\# 项目概述

这是一个基于 Bruno 的接口自动化测试项目，用于测试用户管理相关的 API。包含 Mock 服务、数据驱动测试、CI 集成等功能。

| 项目 | 说明 |

| \*\*技术栈\*\* | Bruno、Node.js、Express、Faker.js |

| \*\*测试类型\*\* | 接口测试、数据驱动测试、Mock测试 |

| \*\*项目周期\*\* | 7天 |

| \*\*测试接口数\*\* | 12个 |

| \*\*总断言数\*\* | 34个 |



\# 项目结构

D:\\bruno-test├── mock-server/    # Mock服务

├── server.js    # 主服务代码

│   └── package.json           # 依赖配置

├── user-tests/                # 用户测试

├── get-users.yml

├── create-user.yml

├── update-user.yml

└── delete-user.yml

├── post-tests/    # 文章测试

├── mock-data.csv              # 数据驱动文件

├── opencollection.yml         # 集合配置

├── screenshots/               # 项目截图

└── .github/workflows/         # CI配置

└── test.yml



\# 测试覆盖统计

| 测试模块 | 接口数 | 断言数 | 状态 |

| 用户基础操作 | 4 | 12 | ✅ 全部通过 |

| 用户详情嵌套 | 2 | 10 | ✅ 全部通过 |

| 数据驱动测试 | 3 | 9 | ✅ 全部通过 |

| 错误场景模拟 | 3 | 8 | ✅ 全部通过 |

| \*\*总计\*\* | \*\*12\*\* | \*\*34\*\* | ✅ \*\*全部通过\*\* |



\#快速开始

cd D:\\bruno-test\\mock-server

npm install

node server.js



\#项目亮点

1\. 从零搭建完整测试框架

独立搭建了基于 Bruno 的接口自动化测试框架，包括 Mock 服务、数据驱动、CI 集成，覆盖 12 个核心接口，34 个断言全部通过。

2\. 解决变量作用域问题

在 Bruno v3 中遇到变量无法传递的问题，通过分析官方文档和调试，最终用 bru.setVar() 和 Vars 标签结合的方式解决。

3\. 处理中文乱码

在 Windows 环境下，CSV 文件中文乱码是个常见问题。通过用命令行创建 UTF-8 无 BOM 文件，彻底解决了这个问题。

4\. 复杂嵌套断言

实现了对多层嵌套 JSON 的深度断言，验证了包括对象、数组、嵌套属性在内的各种数据结构。



🔧 常见问题

Q: 运行测试时提示找不到文件？

A: 确保当前在 D:\\bruno-test 目录下。

Q: Mock 服务启动失败？

A: 检查端口 3000 是否被占用，可以改成 3001。

Q: 断言一直失败？

A: 先用 console.log 打印返回数据，看看实际结构。

Q: 报告中显示“1 skipped”？

A: 这是正常的，有一个请求没有加断言（如 user-random），不影响整体测试结果。



📌 项目总结

通过这个项目，我掌握了：

✅ Bruno 接口测试工具的使用

✅ Node.js + Express 搭建 Mock 服务·

✅ 数据驱动测试（CSV + CLI）

✅ 复杂 JSON 结构的断言编写

✅ GitHub Actions 持续集成

✅ 测试报告生成和查看






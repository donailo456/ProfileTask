### Профильное задание для VK
![Swift Version Shield](https://img.shields.io/badge/Swift%205.0-FA7343?style=flat&logo=swift&logoColor=white)

## Содержание <!-- omit in toc -->

- [О проекте](#о-проекте)
- [Архитектура проекта](#архитектура-проекта)
- [Паттерны проектирования](#паттерны-проектирования)
- [Основной стек технологий](#основной-стек-технологий)
- [Установка](#установка)

# О проекте
Мобильное приложение для просмотра сервисов

- На стартовом экране отображаются сервисы с их названием и кратким описанием.
- Пользователь может выбрать сервис, чтобы перейти на его сайт, нажав на соответствующую ячейку в коллекции.
- Переход на сайт осуществляется через WebViewController, это решение намного быстрее и проще для пользователя.

В приложении была предусмотрена пагинация данных в случае большого количества приходящих данных.

## Архитектура проекта
- MVVM

## Паттерны проектирования 

- Coordinator
- Adapter

## Основной стек технологий:

- UIKit
- FileManager
- WebKit

## Установка

```
    git clone https://github.com/donailo456/ProfileTask.git
    pod install
    cmd+r в Xcode 
```

## Screencast
![Pagination](https://s9.gifyu.com/images/SVcA7.gif)  ![touch](https://s12.gifyu.com/images/SVcA8.gif)

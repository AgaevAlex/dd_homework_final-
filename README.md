# dd_homework_final
DigitalDesign final homework
Реализовать приложение для просмотра фотографий с сайта Flickr

3 экрана:

1) Список популярных тэгов (например, первые 10) (использовать, например, UITableView)
2) Превьюшки фотографий с этими тэгами (тоже первые 10) (использовать, например, UICollectionView, в ячейке - UIImageView)
3) Просмотр выбранной фотографии уже на весь экран.

Каждый экран наполняется информацией, полученной с сервера:
Открыли экран -> Запрос на сервер -> вывод полученной информации на экран

https://www.flickr.com/services/apps/create/
https://www.flickr.com/services/api/


Архитектура слоя представления - MVC
Отдельный класс для работы с сетью сервером (использовать NSURLSession)
Хранить фотографии не нужно, только онлайн режим
Для работы потоками - grand central dispatch

Формат для общения с сервером - JSON (использовать NSJSONSerialization)

Задание «со звёздочкой», Поиск фотографий:

На главном экране добавить кнопку «Поиск», по нажатию на нее появляется строка поиска.
Вбиваем текст, по кнопке «Найти» Ищем фотографии по введённому тексту(например, первые 10).
 
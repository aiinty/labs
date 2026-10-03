# Лабораторная работа №19

## Реализация гетерогенного и горизонтального RecyclerView

### Основные правила

1. Не бойтесь задавать любые вопросы
2. Если хотите сделать что-то свое, то предлагайте – будем думать
3. Советую читать текст, тут написано много полезного
4. 
<img src="_картинки/19/крейзи.png" alt="да чему тебя научила мобилка?">

### О чем лабораторная?

На прошлых занятиях вы научились создавать списки с помощью RecyclerView. Сегодня расширим эти знания: создадим список с разными типами элементов и научимся располагать элементы горизонтально.

---

### Часть 1. Теория

#### Гетерогенный список

В гетерогенном списке элементы могут выглядеть по-разному. Для этого нужно:

1. Определить типы элементов (например, `TYPE_NORMAL`, `TYPE_IMPORTANT`) ([***как создать разные типы можно вспомнить тут***](https://github.com/aiinty/labs/blob/main/мобпри/15-урок-адаптеры-назначение-адаптеров.md))
2. Переопределить `getItemViewType(int position)` - возвращает тип элемента
3. В `onCreateViewHolder` создавать разные макеты в зависимости от типа
4. В `onBindViewHolder` заполнять данными в зависимости от типа

```java
@Override
public int getItemViewType(int position) {
    return items.get(position).getType();   // возвращаем тип элемента по его позиции
}

@Override
public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
    LayoutInflater inflater = LayoutInflater.from(parent.getContext());
    if (viewType == TYPE_IMPORTANT) {
        View view = inflater.inflate(R.layout.item_important, parent, false);
        return new ImportantViewHolder(view);
    } else {
        View view = inflater.inflate(R.layout.item_normal, parent, false);
        return new NormalViewHolder(view);
    }
}
```

#### Горизонтальный список

Горизонтальный список прокручивается слева направо. Для этого нужно использовать `LinearLayoutManager` с горизонтальной ориентацией:

```java
LinearLayoutManager layoutManager = new LinearLayoutManager(this);
layoutManager.setOrientation(LinearLayoutManager.HORIZONTAL);
recyclerView.setLayoutManager(layoutManager);
```

#### Сетка

Для отображения элементов в виде сетки используйте `GridLayoutManager`:

```java
recyclerView.setLayoutManager(new GridLayoutManager(this, 2)); // 2 колонки
```

#### Работа с изображениями

**Шаг 1. Добавьте изображение в ресурсы**

1. Скачайте или создайте изображение (например, `ic_news.png`)
2. Поместите его в папку `res/drawable/`
3. Изображение будет доступно как `R.drawable.ic_news`

**Шаг 2. Добавьте ImageView в макет**

```xml
<ImageView
    android:id="@+id/image_news"
    android:layout_width="match_parent"
    android:layout_height="150dp"
    android:scaleType="centerCrop" />
```

**Шаг 3. Привяжите изображение в адаптере**

```java
@Override
public void onBindViewHolder(RecyclerView.ViewHolder holder, int position) {
    News news = newsList.get(position);
    // проверяем в if ТИП нашей строчки
    if (holder instanceof ImportantViewHolder) {
        // если тип строчки - ImportantViewHolder
        ImportantViewHolder vh = (ImportantViewHolder) holder;
        vh.textTitle.setText(news.getTitle());
        vh.textText.setText(news.getText());
        vh.imageNews.setImageResource(R.drawable.ic_news); // вот тут мы и закидываем изображение
    } else {
        // если тип ДРУГОЙ
        NormalViewHolder vh = (NormalViewHolder) holder;
        vh.textTitle.setText(news.getTitle());
        vh.textText.setText(news.getText());
    }
}
```

---

### Часть 2. Самостоятельная работа

#### Задание

Выберите одну из тем или предложите свою:

1. **Лента новостей** - обычные новости (заголовок + текст) и важные новости (заголовок + текст + изображение)
2. **Каталог товаров** - обычные товары (название + цена) и товары со скидкой (название + цена + старая цена + скидка)
3. **Своя тема** - любой список

Требования к любой теме:

- Создайте модель данных с типом элемента (например, `TYPE_NORMAL`, `TYPE_IMPORTANT`)
- Создайте макеты для каждого типа элементов
- Создайте ViewHolder для каждого типа элементов
- Создайте адаптер с методом `getItemViewType(int position)`
- Реализуйте условную логику отображения (по теме)
- Добавьте обработку клика на элемент списка (просто Toast)

#### Подсказки

Для условного отображения используйте `if` внутри `onBindViewHolder`:

```java
if (movie.getRating() >= 8.0) {
    holder.textRating.setTextColor(Color.GREEN);
} else {
    holder.textRating.setTextColor(Color.BLACK);
}
```

Для обработки клика используйте `setOnClickListener`:

```java
holder.itemView.setOnClickListener(v -> {
    Toast.makeText(v.getContext(), movie.getTitle(), Toast.LENGTH_SHORT).show();
});
```

---

### Требования к итоговой версии

1. Приложение отображает список с разными типами элементов
2. Адаптер корректно определяет тип элемента и использует нужный макет
3. Реализована условная логика отображения
4. Реализована обработка клика на элемент списка (Toast)
5. Все текстовые данные вынесены в `strings.xml`

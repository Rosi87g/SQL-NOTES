# Chapter 1 --- Data: The New Fuel

You use data every single day --- you just never called it that. The
photos on your phone, a friend's contact number, your bank balance, last
night's match score --- all of it is data: small pieces of information
about the world.

## 1.1 What Is Data?

Data is a collection of raw facts, figures, and details --- such as
numbers, text, or dates --- that describe something. On its own, data
has no meaning; it becomes information once it is organized and given
context.

Example: your friend's contact card.

  Field    Value
  -------- -------------
  Name     Rahul
  Number   98765 43210
  City     Bangalore

Data vs Information (a favourite interview question): data is the raw
fact (the number 25); information is data with meaning ("Rahul is 25
years old").

## 1.2 Why Is Data Called "the New Fuel"?

A hundred years ago, the most valuable resource was oil --- it powered
cars, factories, and entire economies. Today, the most valuable resource
is data. Google knows what you search, Amazon knows what you buy,
Netflix knows what you watch and uses it to decide what to recommend
next. The biggest companies in the world don't just sell products ---
their real treasure is the data they hold about people. Just as oil
powered the last century, data powers this one.

## 1.3 Types of Data

Data comes in three types, depending on how neat and organized it is.

### 1. Structured Data

Data that fits perfectly into rows and columns, like a table. Every
piece has a clear, labelled place.

  RollNo   Name    City        Marks
  -------- ------- ----------- -------
  1        Rahul   Bangalore   85
  2        Priya   Mysore      92
  3        Amit    Bangalore   78

More examples: bank transaction records, an Excel sheet of products, an
employee list.

### 2. Unstructured Data

Data with no fixed shape --- it cannot be squeezed into rows and
columns.

-   A photo from a birthday party

-   A WhatsApp voice note

-   A YouTube video

-   A free-text message such as "Hey, are we still meeting tomorrow?"

More examples: images, videos, audio files, social media posts, PDF
documents.

### 3. Semi-structured Data

Not a neat table, but not a total mess either --- it has some structure
(labels or tags) without being a rigid table.

An email has fields (From, To, Subject) but a free-text Body:

``` sql
From:    ajay@kod.comTo:      anuj@kod.comSubject: Meeting TomorrowBody:    Hi Anuj, are we still on for the project         meeting tomorrow at 4 PM? Let me know!
```

A JSON snippet is another common example --- labelled fields, but not a
rigid table:

``` sql
{  "name": "Rahul",  "city": "Bangalore",  "age": 25}
```

More examples: XML files, NoSQL documents.

  -----------------------------------------------------------------------
  Type              Shape             Real-life analogy Examples
  ----------------- ----------------- ----------------- -----------------
  Structured        Fixed rows &      A filled-in form  Excel sheet, SQL
                    columns                             table

  Unstructured      No fixed format   A handwritten     Photos, videos,
                                      diary             audio

  Semi-structured   Partly tagged     A form with an    Email, JSON, XML
                                      "anything else?"  
                                      box               
  -----------------------------------------------------------------------

> 💡 Why This MattersAll this data --- neat or messy --- has to be
> stored, organized so it can be found again, and protected so it isn't
> lost. Companies hold billions of records, and different types of data
> are stored and handled differently. Learning to store, organize, and
> work with data (which is exactly what SQL and databases do) is a skill
> that sits underneath almost every app and company in the world.

## 1.4 Interview Questions --- Chapter 1

Q1. What do you understand by "data"?

Ideal answer: Data is a collection of raw facts and figures --- like
numbers, text, or dates --- that describe something. On its own it's
just a fact; it becomes useful information once it is organized and
given context.

Q2. What is the difference between data and information?

Ideal answer: Data is the raw fact with no meaning by itself --- e.g.,
the number 25. Information is data given context and meaning --- e.g.,
"Rahul is 25 years old." Information is processed, organized data.

Q3. What are the different types of data?

Ideal answer: Three types: Structured (fits rows & columns, e.g. a marks
table), Unstructured (no fixed format, e.g. images, videos, free text),
and Semi-structured (in between, has some tags but isn't a strict table,
e.g. email, JSON).

Q4. Give an example of structured versus unstructured data.

Ideal answer: A table of customer names, cities, and phone numbers is
structured --- it fits perfectly into rows and columns. A folder of
photos or WhatsApp voice notes is unstructured --- real data, but with
no fixed row-and-column format.

Interview tip: for "types of X" questions, name all the types first,
then give one example each --- naming shows breadth, examples show
understanding. For any "what is X" question, give the clean definition
first, then a quick real-life example.

## Interview Questions — Chapter 1

Q1. What is data?

Ideal answer: Data is a collection of raw facts, figures, and details
such as numbers, text, or dates. It becomes information when organized
and given context.

Q2. Why is data important to modern applications?

Ideal answer: Applications use data to operate, personalize experiences,
make decisions, and maintain records. Storing it reliably is a core
requirement of software systems.

Q3. Structured vs semi-structured data?

Ideal answer: Structured data follows a fixed row-and-column structure.
Semi-structured data has labels or tags but does not require a rigid
table, such as JSON or XML.

Q4. Is JSON structured data?

Ideal answer: In the classification used in these notes, JSON is
semi-structured because it contains labeled fields without requiring a
rigid relational table.

Q5. Give a data-to-information example.

Ideal answer: The value 25 is data; 'Rahul is 25 years old' adds context
and meaning, making it information.
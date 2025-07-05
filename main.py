def generate_task(topic=None, year=None, number=None):
    return f"Сгенерировано задание по теме: {topic or 'общая'}, год: {year or 'не указан'}, номер: {number or 'не указан'}"

if __name__ == "__main__":
    print(generate_task("лирика", 2023, 8))

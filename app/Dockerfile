FROM python:3.7

WORKDIR /comments

COPY api.py requirements.txt ecs-task-prd-comment.json .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["python", "api.py"]
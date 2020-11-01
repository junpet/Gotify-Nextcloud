FROM python:alpine

WORKDIR /app

COPY . .
RUN mv settings.py.sample settings.py
RUN mkdir logs
RUN pip install --no-cache-dir -r requirements.txt
RUN rm -rf requirements.txt

CMD [ "python", "./push_msg.py" ]

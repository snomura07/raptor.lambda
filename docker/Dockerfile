FROM public.ecr.aws/lambda/python:3.11

# 依存インストール（必要なら requirements.txt を追加）
COPY src/requirements.txt .  # 任意
RUN pip install -r requirements.txt -t .

# Lambdaコード配置
COPY src/ ${LAMBDA_TASK_ROOT}

# デフォルトのハンドラ（API用 or SQS用に切り替え可能）
CMD ["RaptorLoggerApi.RaptorLoggerApiSetLog.lambda_handler"]

import matplotlib.pyplot as plt
import pandas as pd
import mysql.connector

# MySQL 연결 설정
db_config = {
    'host': '192.168.0.37',
    'user': 'hsk',
    'password': 'hsk',
    'database': 'fr'
}

# MySQL 데이터베이스 연결
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()


# 첫 번째 그래프 - 'member' 데이터 그래프
query_member = "SELECT MREGISTER AS date, COUNT(*) AS cnt FROM member GROUP BY MREGISTER;"
cursor.execute(query_member)
data_member = cursor.fetchall()
df_member = pd.DataFrame(data_member, columns=['date', 'cnt'])

# 날짜 데이터를 datetime 형식으로 변환
df_member['date'] = pd.to_datetime(df_member['date'])
# 최근 7일 데이터만 선택
df_recent_7days = df_member.tail(7)

# 그래프 생성
plt.figure(figsize=(10, 6))  # 그래프 크기 조정 (선택 사항)
plt.bar(df_recent_7days['date'], df_recent_7days['cnt'], color='#20D5A4')  # 막대그래프로 변경
plt.xticks(rotation=0)  # x축 레이블 회전 (선택 사항)
plt.grid(axis='y', which='major', linestyle='--', linewidth=0.5)  # Y축에만 수평 그리드 추가
plt.tight_layout()  # 레이아웃 조정 (선택 사항)

# Y축 레이블 설정 (count 값만 표시)
plt.yticks(df_recent_7days['cnt'])

plt.savefig('static/graph/mgraph.png')  # 'member' 데이터 그래프를 이미지 파일로 저장





#==========================================================================================
# 두 번째 그래프 - 'company' 데이터 그래프
query_company = "SELECT CREGISTER AS date, COUNT(*) AS cnt FROM company GROUP BY CREGISTER;"
cursor.execute(query_company)
data_company = cursor.fetchall()
df_company = pd.DataFrame(data_company, columns=['date', 'cnt'])

# 날짜 데이터를 datetime 형식으로 변환
df_company['date'] = pd.to_datetime(df_company['date'])
# 최근 7일 데이터만 선택
df_recent_7days = df_company.tail(7)

# 그래프 생성
plt.figure(figsize=(10, 6))  # 그래프 크기 조정 (선택 사항)
plt.bar(df_recent_7days['date'], df_recent_7days['cnt'], color='#1DB088')  # 막대그래프로 변경
plt.xticks(rotation=0)  # x축 레이블 회전 (선택 사항)
plt.grid(axis='y', which='major', linestyle='--', linewidth=0.5)  # Y축에만 수평 그리드 추가
plt.tight_layout()  # 레이아웃 조정 (선택 사항)

# Y축 레이블 설정 (count 값만 표시)
plt.yticks(df_recent_7days['cnt'])

plt.savefig('static/graph/cgraph.png')  # 'member' 데이터 그래프를 이미지 파일로 저장
#==========================================================================================
#==========================================================================================
# 세 번째 그래프 - 'project' 데이터 그래프
query_project = "SELECT PINSTARTDATE AS date, COUNT(*) AS cnt FROM project GROUP BY PINSTARTDATE;"
cursor.execute(query_project)
data_project = cursor.fetchall()
df_project = pd.DataFrame(data_project, columns=['date', 'cnt'])

# 날짜 데이터를 datetime 형식으로 변환
df_project['date'] = pd.to_datetime(df_project['date'])
# 최근 7일 데이터만 선택
df_recent_7days = df_project.tail(7)

# 그래프 생성
plt.yticks(range(0, max(df_member['cnt'])+1))  # Y축 눈금 설정
plt.figure(figsize=(10, 6))  # 그래프 크기 조정 (선택 사항)
plt.bar(df_recent_7days['date'], df_recent_7days['cnt'], color='#FF7676')  # 막대그래프로 변경
plt.xticks(rotation=0)  # x축 레이블 회전 (선택 사항)
plt.grid(axis='y', which='major', linestyle='--', linewidth=0.5)  # Y축에만 수평 그리드 추가
plt.tight_layout()  # 레이아웃 조정 (선택 사항)

# Y축 레이블 설정 (count 값만 표시)
plt.yticks(df_recent_7days['cnt'])

plt.savefig('static/graph/pgraph.png')  # 'member' 데이터 그래프를 이미지 파일로 저장
#==========================================================================================
#==========================================================================================
# 네 번째 그래프 - 'question' 데이터 그래프
query_question = "SELECT INSERTDATE AS date, COUNT(*) AS cnt FROM question GROUP BY INSERTDATE;"
cursor.execute(query_question)
data_question = cursor.fetchall()
df_question = pd.DataFrame(data_question, columns=['date', 'cnt'])

# 날짜 데이터를 datetime 형식으로 변환
df_question['date'] = pd.to_datetime(df_question['date'])
# 최근 7일 데이터만 선택
df_recent_7days = df_question.tail(7)

# 그래프 생성
plt.figure(figsize=(10, 6))  # 그래프 크기 조정 (선택 사항)
plt.bar(df_recent_7days['date'], df_recent_7days['cnt'], color='#F46464')  # 막대그래프로 변경
plt.xticks(rotation=0)  # x축 레이블 회전 (선택 사항)
plt.grid(axis='y', which='major', linestyle='--', linewidth=0.5)  # Y축에만 수평 그리드 추가
plt.tight_layout()  # 레이아웃 조정 (선택 사항)

# Y축 레이블 설정 (count 값만 표시)
plt.yticks(df_recent_7days['cnt'])

plt.savefig('static/graph/qgraph.png')  # 'member' 데이터 그래프를 이미지 파일로 저장
#==========================================================================================


# 연결 해제
cursor.close()
conn.close()

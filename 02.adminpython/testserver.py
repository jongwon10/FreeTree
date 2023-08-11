from flask import Flask, render_template, session, url_for, request, redirect
from flask_mysqldb import MySQL

app = Flask(__name__, static_folder='static', static_url_path='/static')
app.config['SECRET_KEY'] = 'your_secret_key_here'

# MySQL 연결 설정
app.config['MYSQL_HOST'] = '192.168.0.37'
app.config['MYSQL_USER'] = 'hsk'
app.config['MYSQL_PASSWORD'] = 'hsk'
app.config['MYSQL_DB'] = 'fr'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# DataBase 객체 생성
mysql = MySQL(app)


@app.route('/')
def adminlogin():
    return render_template('adminlogin.html')

@app.route('/adminlogin_check', methods=['POST'])
def adminlogin_check():
        
        aid = request.form['id']
        apw = request.form['pw']

        conn = mysql.connection
        cursor = conn.cursor()
        query = "SELECT * FROM admin WHERE AID = %s AND APW = %s"
        value = (aid, apw)
        cursor.execute(query, value)
        data = cursor.fetchall()
        cursor.close()

        if data:
            session['id'] = aid
            session['pw'] = apw
            return render_template('loginOK.html')
        else:
            return render_template('loginError.html')

@app.route('/adminmain')
def adminmain():
    if 'id' in session and 'pw' in session:
        return render_template('adminmain.html')  # 로그인 성공 시 adminmain 페이지 보여줌
    else:
        return render_template(url_for('adminlogin'))  # 로그인 실패 시 다시 로그인 페이지로 이동
    
#=======================================[ 회원관리 ]==================================================
@app.route('/adminmem')
def adminmem():
    page = request.args.get('page', default=1, type=int)  # URL 파라미터로부터 페이지 번호를 받아옵니다.
    per_page = 10  # 페이지당 보여줄 데이터 개수를 설정합니다.

    conn = mysql.connection
    cursor = conn.cursor()

      # 회원 정보 쿼리 실행
    query_member = "SELECT MREGISTER, MNAME, MNICK, MEMAIL FROM member"
    cursor.execute(query_member)
    data_member = cursor.fetchall()
   
      # 회사 정보 쿼리 실행
    query_company = "SELECT CREGISTER, CNAME, CEMAIL, CHP, CPERSONNEL, CLEAVE, CNUM FROM company"
    cursor.execute(query_company)
    data_company = cursor.fetchall()

    cursor.close()

    # 페이지 번호에 따라 데이터 슬라이싱
    start_idx = (page - 1) * per_page
    end_idx = page * per_page

 # 회원 정보와 회사 정보를 하나의 딕셔너리로 묶어서 템플릿에 전달
    data = {
        "members": data_member[start_idx:end_idx],
        "company": data_company[start_idx:end_idx],
        "page": page,  # 페이지 번호를 템플릿으로 전달
        "last_page": (len(data_member) + len(data_company) - 1) // per_page,  # 전체 페이지 수 계산
    }
    return render_template('adminmem.html', data=data)

#---------------------------------회원 가입승인 ( 업데이트)--------------------------------------
@app.route('/cleaveUpdate', methods=['POST', 'GET'])  # GET 요청도 허용하도록 수정
def cleaveUpdate():
    if 'id' in session and 'pw' in session:
        try:
            if request.method == 'POST':  # POST 요청만 처리하도록 조건 추가
                # 클라이언트에서 보낸 데이터를 서버에서 받아와 출력해봅니다.
                cnum = request.form.get('cnum')
                cleave = request.form.get('cleave')

                print("cnum:", cnum)
                print("cleave:", cleave)

                # 쿼리 실행하여 해당 회사의 CLEAVE 값을 업데이트합니다.
                query_update = "UPDATE company SET CLEAVE = %s WHERE CNUM = %s;"
                mysql.connection.cursor().execute(query_update, (cleave, cnum))
                mysql.connection.commit()

                return "Success"
        except Exception as e:
            print("Error updating CLEAVE:", e)

    return "Error"
#====================================================================================================
@app.route('/adminboard', methods=['GET','POST'])
def adminboard():
    if 'id' in session and 'pw' in session:

        cur = mysql.connection.cursor()

        if request.method == 'GET':
            adminboard = """
            SELECT
                PROJECT.PNUM,
                    PROJECT.PNAME,
                    PROJECT.PINENDDATE,
                    PROJECT.PSTARTDATE,
                    PROJECT.PENDDATE,
                    PROJECT.PLIMIT,
                    PROJECT.PINTRODUCTION,
                    PROJECT.PWORK,
                    PROJECT.PCONDITION,
                    PROJECT.PBENEFIT,
                    PROJECT.PANNUAL,
                    PROJECT.PDEMAND,
                    PROJECT.CNUM,
                    PROJECT.PPAYMIN,
                    PROJECT.PPAYMAX,
                    PROJECT.PRESIDE,
                    PROJECT.PSKILL,
                    PROJECT.CHP,
                    PROJECT.PDELETE,
                    PROJECT.PSTATUS,
                    PROJECT.PINSTATUS,
                    PROJECT.PINYES,
                    PROJECT.PINSTARTDATE,
                    COMPANY.CNAME
                FROM PROJECT
                JOIN COMPANY ON PROJECT.CNUM = COMPANY.CNUM
                WHERE PROJECT.PDELETE = 'Y'
                ORDER BY PSTARTDATE DESC;
                            """
            print("boardSelectAll", adminboard)
            cur.execute(adminboard)
            mem_list = cur.fetchall()
            print("mem_list", mem_list)
            cur.close()

            return render_template('adminboard.html', mem_list=mem_list)
        
        # GET 메서드로 요청될 때는 빈 리스트를 템플릿에 전달하여 렌더링하도록 수정
        return render_template('adminmain.html', alram_list=[])

    else:
        return redirect(url_for('adminlogin'))
    
#==========================================[ QnA삭제 ]============================================
@app.route('/adminboardDelete', methods=['POST'])
def adminboardDelete():
    if 'id' in session and 'pw' in session:
        # MySQL 데이터베이스 연결
        conn = mysql.connection
        cursor = conn.cursor()
        
        try:
            pnums = request.form.getlist('pnum')
            print("pnums", pnums)
            adminboarddelete_query = """
                UPDATE PROJECT
                SET PDELETE = 'N'
                WHERE PNUM IN %(pnums)s
            """
            print("adminboarddelete_query", adminboarddelete_query)
            cursor.execute(adminboarddelete_query, {'pnums': pnums})
            board_list = cursor.fetchall()
            print("alram_list", board_list)
            conn.commit()
            cursor.close()

            return render_template('adminboardDelete.html', board_list=board_list)

        except Exception as e:
            print("SQL 쿼리 실행 중 오류:", e)
            return redirect(url_for('adminboard'))

    else:
        return redirect(url_for('adminlogin'))
 #===========================================[ FAQ 페이지 ]============================================

    
###############################알람 보내기 성공 새로고침##############################
@app.route('/adminalramOK')
def adminalramOK():
    return render_template('adminalramOK.html')
#============================================[ 알람 페이지 ]==========================================
# 알람 페이지 라우트
@app.route('/adminalramSelectAll', methods=['GET', 'POST'])
def adminalramSelectAll():
    if 'id' in session and 'pw' in session:

            # 인설트
        if request.method == 'POST':
            # 클라이언트에서 POST로 전송한 데이터를 받음
            title = request.form['title']
            email = request.form['email'] #받는 사람 이메일
            content = request.form['content']
            
            # 이메일 검사
            cur = mysql.connection.cursor()
            if request.method == 'POST':
                alramSelect = """
                              SELECT MNAME FROM MEMBER WHERE MEMAIL = '{email}'
                        """
            print("alramSelect", alramSelect)
            cur.execute(alramSelect)
            alram_e = cur.fetchall()
            print(alram_e)
            cur.close()

            # 데이터베이스에 알림 추가
            insert_query = f"""
                INSERT INTO ALARM (ALSEND, ALNAME, ALEMAIL, ALCONTENT, ALRECEIVING, ALSENDMNUM, ALRECEIVCNUM)
                VALUES (now(), '{title}', '{email}', '{content}', 'Y', 'M202308020002', 'C202308040001')
            """
            print("insert_query", insert_query)
            cur = mysql.connection.cursor()
            cur.execute(insert_query)
            mysql.connection.commit()
            cur.close()
            return redirect(url_for('adminalramOK'))
        # MySQL 데이터베이스 연결
        cur = mysql.connection.cursor()

        if request.method == 'GET':
            alramSelectAll = """
                SELECT
                    ALARM.ALNUM,
                    ALARM.ALRECEIVING,
                    ALARM.ALSEND,
                    ALARM.ALSENDMNUM,
                    ALARM.ALSENDCNUM,
                    ALARM.ALRECEIVMNUM,
                    ALARM.ALRECEIVCNUM,
                    ALARM.ALCONTENT,
                    ALARM.ALNAME,
                    ALARM.ALEMAIL,
                    COMPANY.CNAME,
                    MEMBER.MNAME
                FROM ALARM
                INNER JOIN MEMBER ON ALARM.ALSENDMNUM = MEMBER.MNUM
                INNER JOIN COMPANY ON ALARM.ALRECEIVCNUM = COMPANY.CNUM
                WHERE ALRECEIVING = 'Y'
                ORDER BY ALNUM DESC;
            """
            print("alramSelectAll", alramSelectAll)
            cur.execute(alramSelectAll)
            alram_list = cur.fetchall()
            print("alram_list", alram_list)
            cur.close()

            return render_template('adminalramSelectAll.html', alram_list=alram_list)
        
        # GET 메서드로 요청될 때는 빈 리스트를 템플릿에 전달하여 렌더링하도록 수정
        return render_template('adminalram.html', alram_list=[])

    else:
        return redirect(url_for('adminlogin'))
#=====================================================================================================
@app.route('/adminpage', methods=['GET', 'POST'])
def admin():

    # 요청데이터 처리
    if request.method == 'POST':
        searchFilter = request.form.get('af-searchFilter')
        searchText = request.form.get('af-searchText')
        print("Search Filter:", searchFilter)
        print("Search Text:", searchText)
    else :
        searchFilter = "결제번호" # 서치필터
        searchText = "" # 검색어
 
 # 쿼리
    cur = mysql.connection.cursor()
    
    # 전체조회쿼리
    query = f"""
                SELECT ta.tosspnum, ta.tossptotalamount,
                        ta.tosspapprovedat, ta.tossporderid,
                        COALESCE(prj.PNAME, '없음') AS PNAME,
                        COALESCE(cp.CEMAIL, '없음') AS CEMAIL,
                        COALESCE(cp.CNAME, '없음') AS CNAME
                FROM tosspayapi ta
                LEFT JOIN project prj ON ta.pnum = prj.PNUM
                LEFT JOIN company cp ON prj.CNUM = cp.CNUM
            """

    # 검색어 로직
    if searchFilter == None :
        searchFilter = request.form.get('tmpfilter')
        searchText = request.form.get('tmpkeyword')
        print("none 로직 : ", searchFilter,searchText)
    else :
        print("searchFilter : ",searchFilter)
        print("searchText : ",searchText)

    # 필터로직
    if searchFilter == "결제번호":
        searchFilter = "tosspnum"
    elif searchFilter == "기업명":
        searchFilter = "CNAME"
    elif searchFilter == "회원ID":
        searchFilter = "CEMAIL"
    elif searchFilter == "프로젝트명":
        searchFilter = "PNAME"
    elif searchFilter == "결제금액":
        searchFilter = "tossptotalamount"
    elif searchFilter == "결제일시":
        searchFilter = "tosspapprovedat"
    elif searchFilter == "ORDERID":
        searchFilter = "tossporderid"
    else :
        print("searchFilter Error : ", searchFilter)


        

    # 검색조회쿼리
    querySearch =   f"""
                        SELECT *
                        FROM ({query}) AS sall
                        WHERE sall.{searchFilter} LIKE '%{searchText}%'
                    """ 
    
    cur.execute(querySearch)
    data = cur.fetchall()

    # 검색결과 결제금액 카운트
    queryCount =    f"""
                        SELECT COUNT(*) as scount
                        FROM ({querySearch}) AS ssearch
                    """
    cur.execute(queryCount)
    totalcount = cur.fetchall()[0]['scount'] # 총 결과 건수

    queryCount =    f"""
                        SELECT SUM(tossptotalamount) as ssummoney
                        FROM ({querySearch}) AS ssearch
                    """
    cur.execute(queryCount)
    totalmoney = cur.fetchall()[0]['ssummoney'] # 총 금액

    # 페이징 처리
    pageview = 20 # 한페이지에 출력될 건수

    # request.form.get('tmppagenum')으로 가져온 값을 정수로 변환
    nowpage_str = request.form.get('tmppagenum')
    nowpage = int(nowpage_str) if nowpage_str and nowpage_str.isdigit() else 1

    buttonview = 5 # 한페이지에 나타낼 버튼 수

                    # 총 페이지수 계산
    totalpage = (totalcount + pageview - 1) // pageview

                    # 버튼로직 
    buttonstart = max(1, nowpage - (buttonview // 2))
    buttonend = min(totalpage, buttonstart + buttonview - 1)

    if buttonend - buttonstart + 1 < buttonview:
        buttonstart = max(1, buttonend - buttonview + 1)

    buttonlist = list(range(buttonstart, buttonend + 1))


                    # 페이징 로그
    print("현재 페이지:", nowpage)
    print("총 페이지 수:", totalpage)
    print("페이지 버튼 리스트:", buttonlist)

    queryPage = f"""
            SELECT *
            FROM ({querySearch}) AS spage
            ORDER BY 1  -- 정렬
            LIMIT {pageview}
            OFFSET {(nowpage - 1) * pageview};
         """

    print(queryPage)

    cur.execute(queryPage)
    data = cur.fetchall()

    cur.close()

    return render_template('adminfinancials.html', data=data, totalcount=totalcount, totalmoney=totalmoney, nowpage=nowpage, buttonlist=buttonlist, searchFilter=searchFilter, searchText=searchText )

#============================================[ 문의사항 ]==============================================
@app.route('/adminqna', methods=['GET', 'POST'])
def adminqna():
    if 'id' in session and 'pw' in session:
        # MySQL 데이터베이스 연결
        conn = mysql.connection
        cursor = conn.cursor()

        try:
            if request.method == 'GET':
                # 쿼리 실행하여 문의사항(Q&A) 목록 조회
                querySelectAll = """
                    SELECT
                        QNUM,
                        FNUM,
                        QNAME,
                        QCONTENT,
                        QFILE,
                        QANSWER,
                        DELETEYN,
                        INSERTDATE AS INSERTDATE,
                        UPDATEDATE AS UPDATEDATE
                    FROM QUESTION
                    WHERE DELETEYN = 'Y'
                """
                cursor.execute(querySelectAll)
                question_list = cursor.fetchall()
                print(question_list)
                # 연결과 쿼리 실행이 끝나면 커서와 연결을 닫습니다.
                cursor.close()
                

                # question_list와 질문 업데이트 후 결과를 템플릿에 전달하여 출력
                return render_template('adminqna.html', question_list=question_list)

        except Exception as e:
            # 데이터 조회 실패 시 에러 메시지 출력
            print("Error fetching data from database:", e)
            return render_template('adminqna.html', question_list=[])
#---------------------------------------[ 문의사항 상세 페이지 ]----------------------------------------
@app.route('/adminqnaSelect', methods=['GET', 'POST'])
def adminqnaSelect():
    if 'id' in session and 'pw' in session:
        print("들어올")
        # GET 요청에서 쿼리 매개변수인 qnum을 가져옵니다.
        qnum = request.args.get('qnum')
        print("qnum", qnum)
        # MySQL 데이터베이스 연결
        conn = mysql.connection
        cursor = conn.cursor()

        try:
            if request.method=="GET":
            # 쿼리 실행하여 해당 Q&A의 상세 내용과 답변을 조회합니다.
                queryselect = """
                SELECT
                    QNUM,
                    FNUM,
                    QNAME,
                    QCONTENT,
                    QFILE,
                    QANSWER,
                    DELETEYN,
                    INSERTDATE AS INSERTDATE,
                    UPDATEDATE AS UPDATEDATE
                FROM QUESTION
                WHERE QNUM = %s
            """
            cursor.execute(queryselect, (qnum,))
            qna_detail = cursor.fetchone()
            print(qna_detail)

            # qna_detail이 None이 아닌 경우에만 데이터를 가져오도록 확인합니다.
            if qna_detail:
                qna_name = qna_detail['QNAME']  # '이름' 키에 해당하는 값을 가져옵니다.
                print("이름:", qna_name)
            else:
                # 원하는 데이터가 없는 경우에 대한 처리를 추가합니다.
                print("해당하는 데이터가 없습니다.")

             # qna_detail이 None이 아닌 경우에만 데이터를 가져오도록 확인합니다.
            if qna_detail:
                qna_num = qna_detail['FNUM']  # '이름' 키에 해당하는 값을 가져옵니다.
                print("작성자:", qna_num)
            else:
                # 원하는 데이터가 없는 경우에 대한 처리를 추가합니다.
                print("해당하는 데이터가 없습니다.")

            # qna_detail이 None이 아닌 경우에만 데이터를 가져오도록 확인합니다.
            if qna_detail:
                qna_content = qna_detail['QCONTENT']  # '이름' 키에 해당하는 값을 가져옵니다.
                print("이름:", qna_content)
            else:
                # 원하는 데이터가 없는 경우에 대한 처리를 추가합니다.
                print("해당하는 데이터가 없습니다.")

            # qna_detail이 None이 아닌 경우에만 데이터를 가져오도록 확인합니다.
            if qna_detail:
                qna_answer = qna_detail['QANSWER']  # '이름' 키에 해당하는 값을 가져옵니다.
                print("이름:", qna_answer)
            else:
                # 원하는 데이터가 없는 경우에 대한 처리를 추가합니다.
                print("해당하는 데이터가 없습니다.")

               
            # 연결과 쿼리 실행이 끝나면 커서와 연결을 닫습니다.
            cursor.close()

            # qna_detail과 함께 상세 페이지 템플릿(adqSelect.html)에 전달하여 출력합니다.
            return render_template('adminqnaSelect.html', qna_detail=qna_detail)

        except Exception as e:
            # 데이터 조회 실패 시 에러 메시지 출력
            print("Error fetching data from database:", e)
            return redirect(url_for('adminmain'))  # 실패 시 다시 문의사항 목록 페이지로 이동

    else:
        # 로그인이 되어있지 않으면 로그인 페이지로 이동
        return redirect(url_for('adminlogin'))
#========================================================================================================
@app.route('/adminqnaUpdate', methods=['GET'])
def adminqnaUpdate():
    if 'id' in session and 'pw' in session:
        # MySQL 데이터베이스 연결
        conn = mysql.connection
        cursor = conn.cursor()

            
        try:
            # 쿼리 실행하여 해당 Q&A의 QANSWER 값을 업데이트합니다.
            qnum = request.args.get('qnum')
            qanswer = request.args.get('qanswer')

            print("qnum:", qnum)
            print("qanswer:", qanswer)
            # 쿼리 실행하여 해당 Q&A의 상세 내용과 답변을 조회합니다.
            queryupdate = """
                UPDATE question SET QANSWER = %s where QNUM = %s;
            """
            print("SQL 쿼리:", queryupdate)  # 쿼리 확인을 위해 콘솔에 출력
            cursor.execute(queryupdate, (qanswer, qnum))
            qna_update = cursor.fetchone()
            print(qna_update)

            # 커밋을 수행합니다.
            conn.commit()
            # 연결과 쿼리 실행이 끝나면 커서와 연결을 닫습니다.
            cursor.close()

            # qna_update과 함께 상세 페이지 템플릿(adqSelect.html)에 전달하여 출력합니다.
            return render_template('adminqnaUpdate.html', qna_update=qna_update)

        except Exception as e:
            # 데이터 조회 실패 시 에러 메시지 출력
            print("Error fetching data from database:", e)
            return redirect(url_for('adminqnaSelect'))  # 실패 시 다시 문의사항 목록 페이지로 이동

    else:
        # 로그인이 되어있지 않으면 로그인 페이지로 이동
        return redirect(url_for('adminlogin'))
#====================================================================================================

#==========================================[ QnA삭제 ]============================================
@app.route('/adminqnaDelete')
def adminqnaDelete():
    if 'id' in session and 'pw' in session:
        # MySQL 데이터베이스 연결
        conn = mysql.connection
        cursor = conn.cursor()
        
        try:
            # 삭제할 질문의 QNUM을 받아옵니다.
            qnum = request.args.get('qnum')
            print("qnum", qnum)
            # 쿼리 실행하여 해당 Q&A의 상세 내용과 답변을 조회합니다.
            querydelete = """
                UPDATE QUESTION
                SET DELETEYN = 'N',
                    UPDATEDATE = NOW()
                WHERE QNUM = %(qnum)s
            """
            print("SQL 쿼리:", querydelete)  # 쿼리 확인을 위해 콘솔에 출력
            cursor.execute(querydelete, {'qnum': qnum})

            qna_delete = cursor.fetchone()
            print(qna_delete)

            # 커밋을 수행합니다.
            conn.commit()
            # 연결과 쿼리 실행이 끝나면 커서와 연결을 닫습니다.
            cursor.close()

            # qna_update과 함께 상세 페이지 템플릿(adminUpdate.html)에 전달하여 출력합니다.
            return render_template('adminqnaDelete.html', qna_delete=qna_delete)

        except Exception as e:
             #데이터 조회 실패 시 에러 메시지 출력
            print("Error fetching data from database:", e)
            return redirect(url_for('adminqna'))  # 실패 시 다시 문의사항 목록 페이지로 이동
        

    else:
        # 로그인이 되어있지 않으면 로그인 페이지로 이동
        return redirect(url_for('adminlogin'))
 #===========================================[ FAQ 페이지 ]============================================
@app.route('/adminfaq')
def admin_faq():
    # 여기서 adminfaq.html 템플릿을 렌더링하여 반환합니다.
    return render_template('adminfaq.html')    
#====================================================================================================
    
#=================[사이드바 네비]=================
@app.route('/side')
def sidenav():
 return render_template('sidenav.html')
#================================================


if __name__ == '__main__':
    app.run("192.168.0.51", 8082, True)

    #app.run("192.168.0.37", 8080, True)

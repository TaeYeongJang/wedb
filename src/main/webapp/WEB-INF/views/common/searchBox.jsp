<%@page contentType="text/html;charset=utf-8"%>

            <div class="search_bar_sub">
                <form>                        
                    <label for=""><span class="label_tit">날짜지정</span></label>
                    <input type="text" id="datetimepicker1" class="form-control select_date" placeholder="시작일" readonly>                               
                    <span class="typhen">-</span>
                    <input type="text" id="datetimepicker2" class="form-control select_date" placeholder="종료일" readonly>      
                    <button type="button" class="btn_search" id="btn_search">조회</button>
                    <button type="button" class="btn_excel" id="btn_excel">엑셀</button>
                </form>                  
            </div>
function pwCheck(sV) {
    let bool = false;
    let nCnt = 0;
    let nCnt_a = 0;
    let nCnt_x = 0;
    let nCnt_e = 0;
    let nCnt_n = 0;
    console.log(sV)
    if (sV != null && sV.length > 0) {
        let sVlen = sV.length;
        console.log(sVlen);
        if (sVlen <= 12) {

            for (let i = 0; i < sVlen; i++) {

                let cS = sV.charCodeAt(i);

                if (0x61 <= cS && cS <= 0x7A) {
                    nCnt_a++;
                }
                if (0x21 <= cS && cS <= 0x2F) {
                    nCnt_x++;
                }
                if (0x3A <= cS && cS <= 0x40) {
                    nCnt_e++;
                }
                if (0x30 <= cS && cS <= 0x39) {
                    nCnt_n++;
                }
                nCnt++;
            }
            console.log(nCnt_a + " : " + nCnt_x + " : " + nCnt_e + " : " + nCnt_n + " : " + nCnt);
        }

        if ( nCnt_a > 0 && nCnt_x > 0 && nCnt_e > 0 && nCnt_n > 0 && 8 <= nCnt && nCnt <= 20) {
            if (nCnt === nCnt_a + nCnt_n + nCnt_x + nCnt_e) {
                bool = true;
            }
        }
    }
    return bool;
}



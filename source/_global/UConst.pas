unit UConst;

{$DEFINE MANAGE_VERSION}

interface

uses Graphics;

const
  DEMO_VERSION = false;
  {$IFDEF MANAGE_VERSION}
    MANAGEMENT_VERSION = TRUE;
  {$ELSE}
    MANAGEMENT_VERSION = FALSE;
  {$ENDIF}

  DATE_VERSION = 'v.21.03.11';

  MODUL_PATH = '\Software\Invisi\petshop';

  {item_shipment type..................}
  ITEM_TYPE_OPNAME    = 1;
  ITEM_TYPE_MUTASI_MASUK   = 2;
  ITEM_TYPE_MUTASI_KELUAR   = 3;

  ORDER_TYPE_TAX     = 1;
  ORDER_TYPE_NON_TAX = 2;

  TRANS_TYPE_ORDER   = 5;
  TRANS_TYPE_RECEIPT = 6;
  TRANS_TYPE_RETUR   = 7;
  TRANS_TYPE_MUTASI  = 8;

  TRANS_TYPE_PEMBAYARAN  = 9; //pembayaran ke supplier
  TRANS_TYPE_PIUTANG     = 10;//pembayaran dari customer
  TRANS_TYPE_DANA_INPUT  = 11;
  TRANS_TYPE_DANA_OUTPUT = 12;


  

  SALES_TYPE_POS     = 13;
  SALES_TYPE_RETUR     = 14;

  TRANS_TYPE_PAKAI_STOK = 15;

  CONF_INVENTORY       = 1;
  CONF_UDPATE_PRICE    = 2;
  CONF_PREP_COMP       = 3;
  CONF_PREP_SALES      = 4;
  CONF_PREP_ORDER      = 5;
  CONF_PREP_RECEIPT    = 6;
  CONF_PREP_MUSTASI    = 7;
  CONF_PREP_INPUT      = 8;
  CONF_PREP_OPNAME     = 9;
  CONF_PREP_RETUR      = 10;
  CONF_PREP_OUTPUT     = 11;
  CONF_FOOTER1         = 12;
  CONF_FOOTER2         = 13;
  CONF_PREP_SALES_RET  = 14;

  CONF_DISC_VAL_PROMO  = 15;
  CONF_DISC_PROMO      = 16;
  CONF_PPn             = 17;
  CONF_PREP_PAYMENT    = 18;
  CONF_HARGA    = 19;

  HARGA_RATA  = 0;
  HARGA_BELI   = 1;

  {person type..................}
  STT_TYPE_OKE         = 0;
  STT_TYPE_WARNING     = 1;
  STT_TYPE_BANNED      = 2;

  //CASHIER_AKUN       = 1;

  MST_TYPE_UNIT      = 1;
  MST_TYPE_CASHIER   = 2;
  MST_TYPE_SHIFT     = 3;
  MST_TYPE_GUDANG    = 4;
  MST_TYPE_PRODUSEN  = 5;
  MST_TYPE_KEMASAN   = 6;
  MST_TYPE_SERVICE   = 7;
  MST_TYPE_JABATAN   = 8;

  JNS_MULTIPLY    = 1;
  JNS_DISCOUNT    = 2;

  {JNS_MULTIPLY}
  FAKTOR_DISCOUNT_PERCNT = 1;
  FAKTOR_DISCOUNT_VALUE  = 2;

  {JNS_DISCOUNT}
  FAKTOR_MULTIPLY_HRG1 = 1;
  FAKTOR_MULTIPLY_HRG2 = 2;
  FAKTOR_MULTIPLY_HRG3 = 3;

  PROD_HJUAL    = 1;
  PROD_DISCOUNT = 2;
  PROD_POINT    = 3;

  PROD_FAK_ITEM  = 1;
  PROD_FAK_TOTAL = 2;
                    
  PROD_PERIODE_UNLIMITED = 1;
  PROD_PERIODE_PERIODIK  = 2;

  PROD_CUST_CUSTOMER = 1;
  PROD_CUST_MEMBER   = 2;
  PROD_CUST_UNREG    = 3;
  
  FAKTOR_QTY    = 1;
  FAKTOR_VALUE  = 2;

 // FAKTOR_PERCENT = 1;
 // FAKTOR_NILAI   = 2;

  FAKTOR_KELIPATAN_QTY   = 1;
  FAKTOR_KELIPATAN_NILAI = 2;
  FAKTOR_MINIMAL_QTY     = 3;
  FAKTOR_MINIMAL_NILAI   = 4;

  FAKTOR_HRG1   = 1;
  FAKTOR_HRG2   = 2;
  FAKTOR_HRG3   = 3;

  PREFIX_RESEP = 'R';
  PREFIX_OTC   = 'O';

  JENIS_JASA_MEDIS = 36;


  CENTRAL_BOARD = 1;

  MONEY_TYPE_KAS = 1;

implementation



end.


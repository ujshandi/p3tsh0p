unit UConstTool;

interface

uses Graphics;

const

  {windows version}
  WINDOWS_31 = 'Windows 3.1';
  WINDOWS_95 = 'Microsoft Windows 95';
  WINDOWS_98 = 'Microsoft Windows 98';
  WINDOWS_ME = 'Microsoft Windows Millenium';
  WINDOWS_2K = 'Microsoft Windows 2000';
  WINDOWS_XP = 'Microsoft Windows XP';
  WINDOWS_NT = 'Microsoft Windows NT';
  WINDOWS_XX = 'Unknown Windows Version';


  TIPE_DOCUMENT : array [0..4] of PChar=('-', 'Cash', 'Cheque', 'Bilyet Giro', 'Transfer');
  {
  DOC_TYPE_CASH                         = 'C';  //0
  DOC_TYPE_CHEQUE                       = 'Q';  //1
  DOC_TYPE_GIRO                         = 'G';  //2
  DOC_TYPE_TRANSFER                     = 'T';  //3
  DOC_TYPE_DP                           = 'D';  //4
   }

  {system colors.......................}
  clBanned                              = $00B3B3FF;
  clWarning                             = $00B0FFFF;
  clFinish                              = $00000000;
  clUnFinish                            = $00006C00;
  clProceed                             = $00137375;
  clExpired                             = $00000097;

  {object field constants..............}
  DOC_STATUS_UNPROCESSED                = 'U';
  DOC_STATUS_ACCEPTED                   = 'A';
  DOC_STATUS_REJECTED                   = 'R';

  {menu groups.........................}
  MENU_GROUP_SYSTEM                     = 'System';
  MENU_GROUP_FINANCE                    = 'Finance';
  MENU_GROUP_INVENTORY                  = 'Inventory';
  MENU_GROUP_SALES                      = 'Sales';
  MENU_GROUP_PURCHASES                  = 'Purchases';

  {user management.....................}
  LEVEL_OPERATOR    = 1;
  LEVEL_SUPERVISOR  = 2;
  LEVEL_MANAGER     = 3;
  LEVEL_ADMIN       = 4;
  LEVEL_OWNER       = 5;
  LEVEL_DEVELOPER   = 8;

  PWD_LENGTH        = 8;

  {item conversion.....................}
  //STOCK_CONVERSION                      = 0;
  //PURCHASE_CONVERSION                   = 1;
  //SALES_CONVERSION                      = 2;

  STOCK_CONV_TEXT                       = 'Stok';
  PURCHASE_CONV_TEXT                    = 'Beli';
  SALES_CONV_TEXT                       = 'Jual';

  USED_CONVERSION                       = -1;
  UNUSED_CONVERSION                     = 0;

  {system messages.....................}
  MSG_UNAUTHORISED_ACCESS               = 'Anda tidak memiliki autorisasi untuk fungsi ini';
  MSG_SAVE_CONFIRMATION                 = 'Apakah data sudah benar?';
  MSG_SAVE_CONFIRMATION_2               = 'Simpan Transaksi?';
  MSG_SUCCESS_SAVING                    = 'Penyimpanan berhasil.';
  MSG_SUCCESS_DELETING                  = 'Penghapusan berhasil.';
  MSG_UNSUCCESS_SAVING                  = 'Data tidak berhasil disimpan. '+#13+
                                          'Silahkan cek ulang data yang anda isi.';
  MSG_SUCCESS_UPDATE                    = 'Update data berhasil.';
  MSG_UNSUCCESS_UPDATE                  = 'Update data gagal.';
  MSG_UNSUCCESS_DELETE                  = 'Hapus data gagal.';
  MSG_DUPLICATE                         = 'Duplikasi data.';
  MSG_NO_DATA_FOUND                     = 'Data tidak ada atau tidak ditemukan.';
  MSG_ADD_DATA                          = 'Penyimpanan berhasil,'+#13+'tambah data lagi ?';
  MSG_NO_NUMBER                         = '[Empty]';
  MSG_SUCCESS_ACTIVATED                 = 'Telah dinon aktifkan.';
  MSG_UNSUCCESS_ACTIVATED               = 'Gagal men-nonaktikkan data.';
  MSG_UNDER_CONSTRUCTION                = 'Sedang Dalam Pengerjaan.';

  {buttons caption.....................}
  BUTTON_SAVE                           = '&Simpan';
  BUTTON_EDIT                           = '&Edit';
  BUTTON_EDIT_DETAIL                    = '&Edit...';
  BUTTON_CANCEL                         = '&Batal';
  BUTTON_PRINT                          = '&Print...';
  BUTTON_DELETE                         = '&Hapus';
  BUTTON_LOAD                           = '&Load';
  BUTTON_RESET                          = '&Reset';
  BUTTON_FILTER_SHOW                    = '&Lihat Filter';
  BUTTON_FILTER_HIDE                    = '&Tutup Filter';
  BUTTON_ADD                            = '&Tambah...';
  BUTTON_DETAIL                         = '&Detail...';
  BUTTON_FIND                           = '&Cari...';
  BUTTON_OK                             = '&O K';

  {action shortcut.....................}
  TAG_NEW                       = -10; // [Ctrl + N]
  TAG_SAVE_EDIT                 = -11; // [Ctrl + S]
  TAG_DELETE                    = -12; // [Ctrl + D]
  TAG_UNDO                      = -13; // [Ctrl + Z]
  TAG_PRINT                     = -14; // [Ctrl + P]
  TAG_CLOSE                     = -15; // [Ctrl + X]
  TAG_FIND                      = -16; // [Ctrl + F]
  TAG_FILTER                    = -17; // [Ctrl + I]
  TAG_DETAIL                    = -18; // [Ctrl + T]
  TAG_LOAD                      = -19; // [Ctrl + L]
  TAG_RESET                     = -20; // [Ctrl + R]
  TAG_BROWSE                    = -21; // [Ctrl + B]
  TAG_OPEN                      = -22; // [Ctrl + B]

  {transaction status..................}
  STATUS_FINISH                         = 'F';
  STATUS_UFINISH                        = 'U';
  STATUS_PROCEED                        = 'P';
  STATUS_EXPIRED                        = 'E';

  {amster document pembayaran}
  ST_ALL          = 0;
  ST_PROCEED      = 1;
  ST_UNPROCEED    = 2;
  ST_REJECTED     = 3; //ditolak // bg kosong
  ST_EXPECTATED   = 4; //sudah cair // diterima
  ST_EXPIRED      = 5; //belum cair cair dan sudah jatuh tempo

  {table field constants...............}
  DB_CR_TYPE_DEBIT                      = 'D';
  DB_CR_TYPE_CREDIT                     = 'C';

  RELASI_TYPE_CUSTOMER                  = 1;
  RELASI_TYPE_SUPPLIER                  = 2;
  RELASI_TYPE_CONTACT_PERSON            = 3;
  RELASI_TYPE_MEMBER                    = 4;
  RELASI_TYPE_SALESMAN                  = 5;


  RELASI_TYPE_CUSTOMER_TEXT             = 'Customer';
  RELASI_TYPE_SUPPLIER_TEXT             = 'Supplier';
  RELASI_TYPE_CONTACT_PERSON_TEXT       = 'Contact Person';

  {document type.......................}
  DOC_TYPE_CASH                         = '1'; //'C';  //0
  DOC_TYPE_CHEQUE                       = '2'; //'Q';  //1
  DOC_TYPE_GIRO                         = '3'; //'G';  //2
  DOC_TYPE_TRANSFER                     = '4'; //'T';  //3
  DOC_TYPE_DP                           = '5'; //'D';  //4

  DOC_TYPE_CASH_TEXT                    = 'Cash';
  DOC_TYPE_CHEQUE_TEXT                  = 'Cheque';
  DOC_TYPE_GIRO_TEXT                    = 'Bilyet Giro';
  DOC_TYPE_TRANSFER_TEXT                = 'Transfer';
  DOC_TYPE_DP_TEXT                      = 'Sisa';

  MONEY_TYPE_CASH                       = 'C';
  MONEY_TYPE_BANK                       = 'B';
  MONEY_TYPE_CASH_TEXT                  = 'Cash';
  MONEY_TYPE_BANK_TEXT                  = 'Bank';

  {account type........................}
  ACCOUNT_TYPE_HARTA                    = '1';
  ACCOUNT_TYPE_KEWAJIBAN                = '2';
  ACCOUNT_TYPE_MODAL                    = '3';
  ACCOUNT_TYPE_BIAYA                    = '4';
  ACCOUNT_TYPE_PENDAPATAN               = '5';

  ST_INSERT  = 0;
  ST_EDIT    = 1;

  //OLD_ROW    = 1;
  //NEW_ROW    = 0;

  DEPT_ID_CASHIER = 1;
  
  BACKUP_DATABASE = 0;
  RESTORE_DATABASE = 1;

  CONN_CONNECTED   = 0;
  CONN_UNCONNECTED = 1;

  CAN_ADD = 1;
  CAN_EDIT = 2;
  CAN_DELETE = 3;
  CAN_VIEW = 4;
  CAN_PRINT = 5;

implementation

end.


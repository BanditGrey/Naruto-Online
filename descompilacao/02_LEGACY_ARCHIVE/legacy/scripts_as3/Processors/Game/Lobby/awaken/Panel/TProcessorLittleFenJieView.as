package Processors.Game.Lobby.awaken.Panel
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TAwakenConfig;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.awaken.cell.BaseCell;
   import Processors.Game.Lobby.awaken.date.AwakenDateCELL;
   import Processors.Game.Lobby.awaken.date.AwakenLogicDate;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_AWAKEN;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class TProcessorLittleFenJieView
   {
      
      protected static const TYPE_COUNT:int = 3;
      
      protected static const QUALITYCOLOR_Green:uint = 4285071106;
      
      protected static const QUALITYCOLOR_Blue:uint = 4278228735;
      
      protected static const QUALITYCOLOR_Purple:uint = 4288217295;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = Vector.<uint>([QUALITYCOLOR_Green,QUALITYCOLOR_Blue,QUALITYCOLOR_Purple]);
      
      public static const THREETEN:int = 28;
      
      public static const CLIP_COUNT:int = 3;
      
      public static const BOX_COUNT:int = 6;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FUITabChilder:TUITab;
      
      protected var FCurTabIndexChilder:int;
      
      protected var FMC_FenJie:MovieClip = null;
      
      protected var FFenJiePage:TUIPage = null;
      
      protected var FFenJiePageIndex:int;
      
      protected var FFenJiePageIndexCopy:int;
      
      protected var FBaseSlotFenJieVec:Vector.<BaseCell>;
      
      protected var FFenJieClipVec:Vector.<BaseCell>;
      
      protected var FMC_Slot_:BaseCell;
      
      protected var FMC_Slot__:BaseCell;
      
      protected var FCurNeedFenJieDate:AwakenDateCELL = null;
      
      protected var FFenJieProduceGoods:AwakenDateCELL = null;
      
      protected var FMC_FenJieBtn:MovieClip = null;
      
      protected var FBTN_Reduce:SimpleButton = null;
      
      protected var FBTN_Add:SimpleButton = null;
      
      protected var FBtn_Max:MovieClip = null;
      
      protected var FMC_SaiXuanJiNeng:MovieClip;
      
      protected var FMC_SaiXuanJiNeng_Vector:Vector.<MovieClip>;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Count:TextField = null;
      
      protected var FFenJieShowCount:int;
      
      protected var FCurVec:Vector.<AwakenDateCELL> = null;
      
      protected var FAwakenDatas:AwakenLogicDate;
      
      protected var FCurTabIndex:int;
      
      protected var FTF_GetCount:TextField = null;
      
      protected var FBtnClickBack:Function;
      
      protected var FBackOver:Function;
      
      protected var FBackOut:Function;
      
      protected var FBackMove:Function;
      
      protected var FMax:int;
      
      protected var FCurIndex:int;
      
      protected var FTextFormat:TextFormat;
      
      protected var FBTN_Auto:SimpleButton;
      
      public var NameStr:String;
      
      protected var FUIGoldConfirmation:TUIWindowConfirmation;
      
      public function TProcessorLittleFenJieView(param1:TUIComponent)
      {
         super();
         this.FUITabChilder = new TUITab(param1);
         this.FFenJiePage = new TUIPage(param1);
         this.FBaseSlotFenJieVec = new Vector.<BaseCell>(THREETEN);
         this.FFenJieClipVec = new Vector.<BaseCell>(BOX_COUNT * CLIP_COUNT);
         this.FAwakenDatas = SLogicsCore.AwakenDate;
         this.FMC_SaiXuanJiNeng_Vector = new Vector.<MovieClip>(TYPE_COUNT);
         this.FTextFormat = new TextFormat();
         this.FUIGoldConfirmation = new TUIWindowConfirmation(param1.Parent);
      }
      
      public function SetPanel(param1:MovieClip) : void
      {
         this.FFenJieShowCount = 1;
         this.FThisPanel = param1;
         this.InitilizationView();
      }
      
      protected function InitilizationView() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:BaseCell = null;
         this.FMC_FenJieBtn = this.FThisPanel["MC_FenJieBtn"];
         TGameUtil.setButtonMode(this.FMC_FenJieBtn,true);
         this.FBTN_Reduce = this.FThisPanel["BTN_Reduce"];
         this.FBTN_Add = this.FThisPanel["BTN_Add"];
         this.FBtn_Max = this.FThisPanel["Btn_Max"];
         TGameUtil.setButtonMode(this.FBtn_Max,true);
         this.FBTN_Auto = this.FThisPanel["BTN_Auto"];
         this.FTF_Count = this.FThisPanel["TF_Count"];
         this.FTF_Count.restrict = "0-9";
         this.FTF_Count.maxChars = 4;
         this.FTF_GetCount = this.FThisPanel["TF_GetCount"];
         this.FUITabChilder.SetTabByIndex(this.FThisPanel["MC_Fragment"],0);
         this.FUITabChilder.SetTabByIndex(this.FThisPanel["MC_AwakenSkill"],1);
         this.FUITabChilder.OnSwitch = this.TabOnSwitchChilder;
         this.FUITabChilder.Init();
         this.FFenJiePage.ButtonPrevious.Substrate = this.FThisPanel["MC_Page"]["MC_PageLeft"];
         this.FFenJiePage.ButtonNext.Substrate = this.FThisPanel["MC_Page"]["MC_PageRight"];
         this.FFenJiePage.LabelPage = this.FThisPanel["MC_Page"]["TF_Page"];
         TextField(this.FThisPanel["MC_Page"]["TF_Page"]).text = "1/1";
         this.FFenJiePage.PageSize = THREETEN;
         this.FFenJiePage.Init();
         this.FFenJiePage.OnChangePage = this.FenJiePageOnChange;
         _loc1_ = 0;
         while(_loc1_ < THREETEN)
         {
            _loc2_ = new BaseCell();
            _loc2_.SetPanel(this.FThisPanel["MC_Slot_" + _loc1_]);
            _loc2_.BackClick = this.FenJieFunction;
            _loc2_.BackOver = this.FBackOver;
            _loc2_.BackOut = this.FBackOut;
            _loc2_.BackMove = this.FBackMove;
            this.FBaseSlotFenJieVec[_loc1_] = _loc2_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = 0;
            while(_loc3_ < CLIP_COUNT)
            {
               _loc2_ = new BaseCell();
               _loc2_.SetPanel(this.FThisPanel["MC_Box" + _loc1_]["MC_Slot_" + _loc3_]);
               _loc2_.BackClick = this.FenJieFunction;
               _loc2_.BackOver = this.FBackOver;
               _loc2_.BackOut = this.FBackOut;
               _loc2_.BackMove = this.FBackMove;
               this.FFenJieClipVec[_loc1_ * CLIP_COUNT + _loc3_] = _loc2_;
               _loc3_++;
            }
            _loc1_++;
         }
         this.FMC_Slot_ = new BaseCell();
         this.FMC_Slot_.SetPanel(this.FThisPanel["MC_Slot_"]);
         this.FMC_Slot_.BackOver = this.FBackOver;
         this.FMC_Slot_.BackOut = this.FBackOut;
         this.FMC_Slot_.BackMove = this.FBackMove;
         this.FMC_Slot__ = new BaseCell();
         this.FMC_Slot__.SetPanel(this.FThisPanel["MC_Slot__"]);
         this.FMC_Slot__.BackOver = this.FBackOver;
         this.FMC_Slot__.BackOut = this.FBackOut;
         this.FMC_Slot__.BackMove = this.FBackMove;
         this.FFenJieProduceGoods = new AwakenDateCELL();
         this.FFenJieProduceGoods.SetValueById(this.FAwakenDatas.SuiPianId);
         this.FMC_FenJieBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FBTN_Reduce.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FBTN_Add.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FBtn_Max.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FBTN_Auto.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FTF_Count.addEventListener(Event.CHANGE,this.HandleClickChange);
         this.FMC_SaiXuanJiNeng = this.ThisPanel["MC_SaiXuanJiNeng"];
         if(this.FMC_SaiXuanJiNeng)
         {
            this.FTF_Name = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_0"]["TF_Name"];
            _loc3_ = 0;
            while(_loc3_ < TYPE_COUNT)
            {
               this.FMC_SaiXuanJiNeng_Vector[_loc3_] = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"]["mc_" + _loc3_];
               this.FMC_SaiXuanJiNeng_Vector[_loc3_].buttonMode = true;
               this.FMC_SaiXuanJiNeng_Vector[_loc3_].addEventListener(MouseEvent.CLICK,this.SaiXuanJiNengClick);
               _loc3_++;
            }
            TGameUtil.setButtonMode(this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_0"]["btn_showlist"],true);
            this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_0"]["btn_showlist"].addEventListener(MouseEvent.CLICK,this.SaiXuanshowlistClick);
            this.SetVisibelByValue(false);
         }
         this.FUIGoldConfirmation.OnOK = this.GoldConfirmationOnOK;
         this.FUIGoldConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIGoldConfirmation.WindowWidth) / 2;
         this.FUIGoldConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIGoldConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIGoldConfirmation);
         this.FUIGoldConfirmation.SetCheckBox(true);
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_FenJieBtn:
               if(this.FCurNeedFenJieDate)
               {
                  if(this.FBtnClickBack != null)
                  {
                     this.FBtnClickBack(1,this.FCurNeedFenJieDate.AwakenConfigDate.Identifier,this.FFenJieShowCount,this.FFenJieProduceGoods.AwakenConfigDate.Name,this.FFenJieProduceGoods.Count);
                  }
               }
               break;
            case this.FBTN_Reduce:
               --this.FFenJieShowCount;
               this.UpdateFenJieLeftTwoSot();
               break;
            case this.FBTN_Add:
               ++this.FFenJieShowCount;
               this.UpdateFenJieLeftTwoSot();
               break;
            case this.FBtn_Max:
               if(this.FCurNeedFenJieDate)
               {
                  this.FFenJieShowCount = this.FCurNeedFenJieDate.Count;
                  this.UpdateFenJieLeftTwoSot();
               }
               break;
            case this.FBTN_Auto:
               if(!this.FUIGoldConfirmation.IsSelected)
               {
                  this.FUIGoldConfirmation.Text = STRING_AWAKEN.STRING_FenJieStr[this.FCurIndex];
                  this.FUIGoldConfirmation.SetCheckBox(true);
                  this.FUIGoldConfirmation.Visible = true;
               }
               else
               {
                  this.GoldConfirmationOnOK();
               }
         }
      }
      
      protected function GoldConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_C2S_Awaken_Auto_Fenjie);
         _loc2_.Data.writeUnsignedInt(this.FCurIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function HandleClickChange(param1:Event) : void
      {
         if(!this.FCurNeedFenJieDate)
         {
            this.FTF_Count.text = this.FFenJieShowCount.toString();
            return;
         }
         this.FFenJieShowCount = int(this.FTF_Count.text);
         this.UpdateFenJieLeftTwoSot();
      }
      
      protected function SaiXuanJiNengClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_SaiXuanJiNeng_Vector[0]:
               this.FCurIndex = 0;
               break;
            case this.FMC_SaiXuanJiNeng_Vector[1]:
               this.FCurIndex = 1;
               break;
            case this.FMC_SaiXuanJiNeng_Vector[2]:
               this.FCurIndex = 2;
         }
         this.SetVisibelByValue(false);
      }
      
      protected function SaiXuanshowlistClick(param1:MouseEvent) : void
      {
         if(this.FMC_SaiXuanJiNeng)
         {
            if(this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"].visible)
            {
               this.SetVisibelByValue(false);
            }
            else
            {
               this.SetVisibelByValue(true);
            }
         }
      }
      
      public function SetVisibelByValue(param1:Boolean) : void
      {
         if(this.FMC_SaiXuanJiNeng)
         {
            this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"].visible = param1;
            this.FTextFormat.color = QUALITYCOLOR_INDEX[this.FCurIndex];
            this.FTF_Name.text = this.FMC_SaiXuanJiNeng["MC_SaiXuan"]["mc_list"]["mc_" + this.FCurIndex].TF_Name.text;
            this.FTF_Name.setTextFormat(this.FTextFormat);
         }
      }
      
      protected function FenJiePageOnChange(param1:Object, param2:int) : void
      {
         this.FFenJiePageIndex = param2;
         this.FFenJiePageIndexCopy = 0;
         this.FFenJiePageIndexCopy += this.FFenJiePageIndex * THREETEN;
         this.UpdateFenJieView();
      }
      
      protected function TabOnSwitchChilder(param1:Object) : void
      {
         this.FCurTabIndex = param1 as int;
         this.FFenJiePageIndex = 0;
         this.FCurNeedFenJieDate = null;
         this.SetValueForVec();
         this.UpdateFenJiePage();
         this.UpdateFenJieView();
      }
      
      public function SetValueForVec() : void
      {
         if(this.FCurTabIndex == 0)
         {
            this.FCurVec = this.FAwakenDatas.GetVectorByType(2);
         }
         else
         {
            this.FCurVec = this.FAwakenDatas.GetVectorByType(3,false);
         }
      }
      
      public function UpdateFenJieView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:AwakenDateCELL = null;
         var _loc9_:TAwakenConfig = null;
         var _loc10_:int = 0;
         if(this.FCurTabIndex == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < THREETEN)
            {
               this.FThisPanel["MC_Slot_" + _loc1_].visible = false;
               _loc1_++;
            }
            _loc3_ = this.FAwakenDatas.TotalClipType();
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               this.FThisPanel["MC_Box" + _loc1_].visible = true;
               _loc1_++;
            }
            _loc7_ = 0;
            while(_loc7_ < BOX_COUNT * CLIP_COUNT)
            {
               _loc6_ = this.FFenJiePageIndex * BOX_COUNT * CLIP_COUNT + _loc7_;
               if(_loc6_ >= _loc3_)
               {
                  this.FFenJieClipVec[_loc7_].SetDate(null);
                  if(_loc7_ % CLIP_COUNT == 0)
                  {
                     this.ThisPanel["MC_Box" + _loc7_ / CLIP_COUNT].TF_Title.text = "";
                  }
               }
               else
               {
                  _loc9_ = this.FAwakenDatas.AwakenConfigBins.GetDatebaseByIndex(_loc6_) as TAwakenConfig;
                  _loc10_ = this.FAwakenDatas.GetClipIndexByID(_loc9_.Identifier,this.FCurVec);
                  if(_loc10_ == -1)
                  {
                     _loc8_ = new AwakenDateCELL();
                     _loc8_.SetValueById(_loc9_.Identifier);
                     _loc8_.Count = 0;
                     this.FFenJieClipVec[_loc7_].SetDate(_loc8_);
                  }
                  else
                  {
                     this.FFenJieClipVec[_loc7_].SetDate(this.FCurVec[_loc10_]);
                  }
                  if(_loc7_ % CLIP_COUNT == 0)
                  {
                     this.ThisPanel["MC_Box" + _loc7_ / CLIP_COUNT].TF_Title.text = _loc9_.Name2;
                  }
               }
               _loc7_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               this.FThisPanel["MC_Box" + _loc1_].visible = false;
               _loc1_++;
            }
            _loc3_ = int(this.FCurVec.length);
            _loc1_ = 0;
            while(_loc1_ < THREETEN)
            {
               this.FThisPanel["MC_Slot_" + _loc1_].visible = true;
               _loc4_ = _loc1_ + this.FFenJiePageIndex * THREETEN;
               if(_loc4_ >= _loc3_)
               {
                  this.FBaseSlotFenJieVec[_loc1_].SetDate(null);
               }
               else
               {
                  this.FBaseSlotFenJieVec[_loc1_].SetDate(this.FCurVec[_loc4_]);
               }
               _loc1_++;
            }
         }
         this.UpdateFenJieLeftTwoSot();
         this.UpdateFenJiePage();
      }
      
      public function UpdateFenJieLeftTwoSot() : void
      {
         this.FMC_Slot_.SetDate(this.FCurNeedFenJieDate);
         if(this.FCurNeedFenJieDate)
         {
            this.UpdateFenJieCount();
            this.FFenJieProduceGoods.Count = this.FCurNeedFenJieDate.AwakenConfigDate.Decomposition * this.FFenJieShowCount;
            this.FMC_Slot__.SetDate(this.FFenJieProduceGoods);
            this.FTF_GetCount.text = TUtilityString.Format(STRING_AWAKEN.Str3001,this.FFenJieProduceGoods.AwakenConfigDate.Name,this.FFenJieProduceGoods.Count);
         }
         else
         {
            this.FFenJieShowCount = 1;
            this.FMC_Slot__.SetDate(null);
            this.UpdateFenJieCount(true);
            this.FTF_GetCount.text = "";
         }
      }
      
      protected function FenJieFunction(param1:AwakenDateCELL) : void
      {
         this.FFenJieShowCount = 0;
         this.FCurNeedFenJieDate = param1;
         this.UpdateFenJieLeftTwoSot();
      }
      
      protected function UpdateFenJieCount(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.FTF_Count.text = this.FFenJieShowCount.toString();
         }
         else if(this.FCurNeedFenJieDate)
         {
            if(this.FFenJieShowCount > this.FCurNeedFenJieDate.Count)
            {
               this.FFenJieShowCount = this.FCurNeedFenJieDate.Count;
            }
            else if(this.FFenJieShowCount <= 0)
            {
               this.FFenJieShowCount = 1;
            }
            this.FTF_Count.text = this.FFenJieShowCount.toString();
         }
      }
      
      public function OpenThisPanel() : void
      {
         this.FFenJiePageIndex = 0;
         this.FFenJiePageIndexCopy = 0;
         this.SetValueForVec();
         this.UpdateFenJiePage();
         this.FCurNeedFenJieDate = null;
         this.UpdateFenJieView();
      }
      
      protected function UpdateFenJiePage() : void
      {
         if(this.FCurTabIndex == 0)
         {
            this.FFenJiePage.PageSize = BOX_COUNT * CLIP_COUNT;
            this.FFenJiePage.TotalQuantity = this.FAwakenDatas.TotalClipType();
            this.FFenJiePage.PageIndex = this.FFenJiePageIndex;
            this.FFenJiePage.Update();
         }
         else
         {
            this.FFenJiePage.PageSize = THREETEN;
            this.FFenJiePage.TotalQuantity = this.FCurVec.length;
            this.FFenJiePage.PageIndex = this.FFenJiePageIndex;
            this.FFenJiePage.Update();
         }
      }
      
      public function UpdateImage() : void
      {
         var _loc1_:int = 0;
         if(!this.FThisPanel.visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FBaseSlotFenJieVec.length)
         {
            this.FBaseSlotFenJieVec[_loc1_].UpdateImage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FFenJieClipVec.length)
         {
            this.FFenJieClipVec[_loc1_].UpdateImage();
            _loc1_++;
         }
         if(this.FCurNeedFenJieDate)
         {
            this.FMC_Slot_.UpdateImage();
         }
         if(this.FFenJieProduceGoods)
         {
            this.FMC_Slot__.UpdateImage();
         }
      }
      
      public function set CurNeedFenJieDate(param1:AwakenDateCELL) : void
      {
         this.FCurNeedFenJieDate = param1;
      }
      
      public function set BtnClickBack(param1:Function) : void
      {
         this.FBtnClickBack = param1;
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      public function set BackOver(param1:Function) : void
      {
         this.FBackOver = param1;
      }
      
      public function set BackOut(param1:Function) : void
      {
         this.FBackOut = param1;
      }
      
      public function set BackMove(param1:Function) : void
      {
         this.FBackMove = param1;
      }
   }
}


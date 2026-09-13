package Processors.Game.Lobby.Exercise.MyActivity
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseActivity;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Rendering.Overlayers.MyActivity.TOverlayerMyActivity;
   import Resources.Constants.CONST_MyActivity;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_MUYEJUJIUWU;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class TProcessorActivityMuYeJuJiuWu extends TProcessorBaseActivity
   {
      
      protected static var TEXT_FORMAT:TextFormat;
      
      protected static var GOLD_FORMAT:TextFormat;
      
      protected static const MAX_COUNT:int = 5;
      
      protected var FHD_1:MovieClip;
      
      protected var FHD_2:MovieClip;
      
      protected var FHD_3:MovieClip;
      
      protected var FHD_4:MovieClip;
      
      private var FerrorCode:int;
      
      private var FstartTime:String;
      
      private var FendTime:String;
      
      private var FactDesc:String;
      
      private var FmoneyEvryDay:Array;
      
      private var FaccumulateMoney:int;
      
      private var FnextNeedMoney:int;
      
      private var FdayLeft:int;
      
      private var FboxInfo:Array;
      
      private var FTOverlayerMyActivity:TOverlayerMyActivity;
      
      protected var FTextField:TextField;
      
      protected var FBoxStatus:int;
      
      protected var FReturnGold:int;
      
      protected var FCommandGold:int;
      
      protected var FBeClicked:Boolean;
      
      public function TProcessorActivityMuYeJuJiuWu(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FInitialized = false;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
         this.FHD_1 = FMC_Scene[CONST_MyActivity.RESOURCE_HD_1];
         this.FHD_2 = FMC_Scene[CONST_MyActivity.RESOURCE_HD_2];
         this.FHD_3 = FMC_Scene[CONST_MyActivity.RESOURCE_HD_3];
         this.FHD_4 = FMC_Scene[CONST_MyActivity.RESOURCE_HD_4];
         this.FTOverlayerMyActivity = new TOverlayerMyActivity(this.parent as TUIComponent);
         this.FTOverlayerMyActivity.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTOverlayerMyActivity);
         this.FTextField = new TextField();
         if(TEXT_FORMAT == null)
         {
            TEXT_FORMAT = new TextFormat();
            TEXT_FORMAT.color = "0x000000";
         }
         if(GOLD_FORMAT == null)
         {
            GOLD_FORMAT = new TextFormat();
            GOLD_FORMAT.color = "0x2CBCB5";
         }
      }
      
      protected function OverlayerMyActivityHelpOnOver(param1:Event) : void
      {
         this.FTOverlayerMyActivity.Context = STRING_MUYEJUJIUWU.MYACTIVITY_L12;
         this.FTOverlayerMyActivity.Render(FUICore.MouseCoordinate);
         this.FTOverlayerMyActivity.Show();
      }
      
      protected function OverlayerMyActivityOnOver(param1:Event) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget);
         FHtmlHint.Content = null;
         FHtmlHint.Content = _loc2_.tips != null ? _loc2_.tips : STRING_MUYEJUJIUWU.MYACTIVITY_L7;
         UIHelpTipsHintOnOver(this,FHtmlHint);
      }
      
      protected function OverlayerMyActivityOnOut(param1:Event) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      protected function OverlayerMyActivityHelpOnOut(param1:Event) : void
      {
         this.FTOverlayerMyActivity.Hide();
      }
      
      private function closeActivity() : void
      {
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_MuYeJuJiuWu,false);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonOnClose,false,0,true);
         this.FHD_1.addEventListener(MouseEvent.MOUSE_MOVE,this.OverlayerMyActivityOnOver,false,0,true);
         this.FHD_1.addEventListener(MouseEvent.MOUSE_OUT,this.OverlayerMyActivityOnOut,false,0,true);
         this.FHD_2.addEventListener(MouseEvent.MOUSE_MOVE,this.OverlayerMyActivityOnOver,false,0,true);
         this.FHD_2.addEventListener(MouseEvent.MOUSE_OUT,this.OverlayerMyActivityOnOut,false,0,true);
         this.FHD_3.addEventListener(MouseEvent.MOUSE_MOVE,this.OverlayerMyActivityOnOver,false,0,true);
         this.FHD_3.addEventListener(MouseEvent.MOUSE_OUT,this.OverlayerMyActivityOnOut,false,0,true);
         this.FHD_4.addEventListener(MouseEvent.MOUSE_MOVE,this.OverlayerMyActivityOnOver,false,0,true);
         this.FHD_4.addEventListener(MouseEvent.MOUSE_OUT,this.OverlayerMyActivityOnOut,false,0,true);
         FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.OverlayerMyActivityHelpOnOver,false,0,true);
         FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.OverlayerMyActivityHelpOnOut,false,0,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnReturnGoldUp,false,0,true);
      }
      
      protected function Init() : void
      {
         this.SEND_MESAAGE();
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:String = null;
         if(param1 == null)
         {
            return;
         }
         this.FerrorCode = param1.Data.readUnsignedInt();
         if(this.FerrorCode != 0)
         {
            return;
         }
         this.FstartTime = TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(param1.Data.readUnsignedInt()) * 1000));
         this.FendTime = TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(param1.Data.readUnsignedInt()) * 1000));
         _loc2_ = TUtilityString.FetchUTF(param1.Data);
         this.FactDesc = TBaseActivity.GetStrByID(_loc2_);
         var _loc3_:uint = param1.Data.readUnsignedShort();
         var _loc4_:int = 0;
         this.FmoneyEvryDay = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this.FmoneyEvryDay.push(param1.Data.readUnsignedInt());
            _loc4_++;
         }
         _loc3_ = 5 - _loc3_;
         while(_loc3_ > 0)
         {
            _loc3_--;
            this.FmoneyEvryDay.push(0);
         }
         this.FaccumulateMoney = param1.Data.readUnsignedInt();
         this.FnextNeedMoney = param1.Data.readUnsignedInt();
         this.FdayLeft = param1.Data.readInt();
         _loc3_ = param1.Data.readUnsignedShort();
         this.FboxInfo = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            this.FboxInfo.push({
               "boxName":TBaseActivity.GetStrByID(TUtilityString.FetchUTF(param1.Data)),
               "returnPrct":param1.Data.readUnsignedInt(),
               "costPrct":param1.Data.readUnsignedInt(),
               "price":param1.Data.readUnsignedInt(),
               "tooltipInfo":TBaseActivity.GetStrByID(TUtilityString.FetchUTF(param1.Data))
            });
            _loc4_++;
         }
         this.FBoxStatus = param1.Data.readUnsignedInt();
         this.FReturnGold = param1.Data.readUnsignedInt();
         this.FCommandGold = param1.Data.readUnsignedInt();
         this.UpdataView();
      }
      
      private function UpdataView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc11_:int = 0;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         TextField(FMC_Scene[CONST_MyActivity.RESOURCE_T1]).text = this.FstartTime + "  -  " + this.FendTime;
         TextField(FMC_Scene[CONST_MyActivity.RESOURCE_T2]).text = this.FactDesc;
         TextField(FMC_Scene[CONST_MyActivity.RESOURCE_XF]).text = this.FaccumulateMoney + STRING_MUYEJUJIUWU.MYACTIVITY_L2;
         TextField(FMC_Scene[CONST_MyActivity.RESOURCE_CHA]).text = TUtilityString.Format(STRING_MUYEJUJIUWU.MYACTIVITY_L11,this.FnextNeedMoney);
         _loc1_ = 1;
         while(_loc1_ < 6)
         {
            _loc4_ = MovieClip(FMC_Scene[CONST_MyActivity.RESOURCE_CONTAINER_ + _loc1_]);
            _loc5_ = STRING_MUYEJUJIUWU[CONST_MyActivity.MYACTIVITY_DAY_ + _loc1_];
            _loc6_ = STRING_MUYEJUJIUWU.MYACTIVITY_L4 + _loc5_ + STRING_MUYEJUJIUWU.MYACTIVITY_L5;
            TextField(MovieClip(FMC_Scene[CONST_MyActivity.RESOURCE_CONTAINER_ + _loc1_])[CONST_MyActivity.RESOURCE_TITLE]).text = _loc6_.toString();
            if(MAX_COUNT - this.FdayLeft == _loc1_ - 1)
            {
               TextField(MovieClip(FMC_Scene[CONST_MyActivity.RESOURCE_CONTAINER_ + _loc1_])[CONST_MyActivity.RESOURCE_TITLE]).setTextFormat(GOLD_FORMAT);
            }
            else
            {
               TextField(MovieClip(FMC_Scene[CONST_MyActivity.RESOURCE_CONTAINER_ + _loc1_])[CONST_MyActivity.RESOURCE_TITLE]).setTextFormat(TEXT_FORMAT);
            }
            if(this.FmoneyEvryDay[_loc1_ - 1] >= this.FCommandGold)
            {
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL1]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL2]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL3]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL4]).visible = true;
               MovieClip(_loc4_["panel5"]).visible = false;
               _loc7_ = STRING_MUYEJUJIUWU.MYACTIVITY_L1 + this.FmoneyEvryDay[_loc1_ - 1] + STRING_MUYEJUJIUWU.MYACTIVITY_L2;
               TextField(_loc4_[CONST_MyActivity.RESOURCE_PANEL4][CONST_MyActivity.RESOURCE_T1]).text = _loc7_.toString();
            }
            else if(this.FmoneyEvryDay[_loc1_ - 1] == 0)
            {
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL2]).visible = true;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL1]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL4]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL3]).visible = false;
               MovieClip(_loc4_["panel5"]).visible = false;
            }
            else if(this.FmoneyEvryDay[_loc1_ - 1] < this.FCommandGold)
            {
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL2]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL1]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL4]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL3]).visible = false;
               MovieClip(_loc4_["panel5"]).visible = true;
               _loc7_ = STRING_MUYEJUJIUWU.MYACTIVITY_L1 + this.FmoneyEvryDay[_loc1_ - 1] + STRING_MUYEJUJIUWU.MYACTIVITY_L2;
               TextField(_loc4_["panel5"][CONST_MyActivity.RESOURCE_T1]).text = _loc7_.toString();
            }
            else
            {
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL2]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL1]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL4]).visible = false;
               MovieClip(_loc4_[CONST_MyActivity.RESOURCE_PANEL3]).visible = true;
               MovieClip(_loc4_["panel5"]).visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ < 5)
         {
            _loc8_ = this.FboxInfo[_loc1_ - 1];
            if(_loc8_ != null)
            {
               _loc9_ = MovieClip(FMC_Scene[CONST_MyActivity.RESOURCE_HD_ + _loc1_]);
               _loc10_ = MovieClip(_loc9_[CONST_MyActivity.RESOURCE_JDT_BG]);
               _loc9_.tips = _loc8_.tooltipInfo;
               TextField(_loc9_[CONST_MyActivity.RESOURCE_FANLI][CONST_MyActivity.RESOURCE_T3]).text = TUtilityString.Format(STRING_MUYEJUJIUWU.MYACTIVITY_L9,_loc8_.returnPrct);
               TextField(_loc9_[CONST_MyActivity.RESOURCE_TITLE]).text = _loc8_.boxName.toString();
               TextField(_loc9_[CONST_MyActivity.RESOURCE_LABEL100]).text = STRING_MUYEJUJIUWU.MYACTIVITY_L8 + _loc8_.costPrct + STRING_MUYEJUJIUWU.MYACTIVITY_L6;
               _loc9_["TF_Price"].text = _loc8_.price + STRING_MUYEJUJIUWU.MYACTIVITY_L2;
               _loc11_ = 1;
               _loc12_ = Number(Number(_loc8_.costPrct) / 100);
               if(_loc1_ == 1)
               {
                  _loc13_ = 1;
               }
               else if(_loc1_ == 2)
               {
                  _loc13_ = 6;
               }
               else if(_loc1_ == 3)
               {
                  _loc13_ = 11;
               }
               else if(_loc1_ == 4)
               {
                  _loc13_ = 16;
               }
               _loc11_ = _loc13_;
               if(_loc12_ >= 1)
               {
                  _loc11_ = _loc13_ + 4;
               }
               else if(_loc12_ >= 0.66)
               {
                  _loc11_ = _loc13_ + 3;
               }
               else if(_loc12_ >= 0.33)
               {
                  _loc11_ = _loc13_ + 2;
               }
               else if(_loc12_ >= 0.1)
               {
                  _loc11_ = _loc13_ + 1;
               }
               MovieClip(_loc9_[CONST_MyActivity.RESOURCE_JDT_BG]).gotoAndStop(_loc11_);
               if(_loc8_.costPrct == 0)
               {
                  _loc9_.jdtbg.filters = [TGameUtil.GaryColorFilters];
               }
               else
               {
                  _loc9_.jdtbg.filters = [];
               }
            }
            _loc1_++;
         }
         this.UpdateBox();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = FMC_Scene.MC_Bar["MC_Bar" + _loc3_];
            if(this.FboxInfo[_loc3_].costPrct >= 100)
            {
               _loc2_.filters = [];
            }
            else
            {
               _loc2_.filters = [TGameUtil.GaryColorFilters];
            }
            _loc3_++;
         }
         if(this.FdayLeft == 0)
         {
            FMC_Scene.MC_End.visible = true;
         }
         else
         {
            FMC_Scene.MC_End.visible = false;
         }
      }
      
      protected function UpdateBox() : void
      {
         FMC_Scene.TF_ReturnGold.text = this.FReturnGold.toString();
         if(this.FBoxStatus == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Mask2.visible = false;
            FMC_Scene.MC_Mask3.visible = false;
            FMC_Scene.MC_Mask4.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.MC_Got.visible = false;
         }
         else if(this.FBoxStatus == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Mask2.visible = false;
            FMC_Scene.MC_Mask3.visible = false;
            FMC_Scene.MC_Mask4.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_Got.visible = true;
         }
         else if(this.FBoxStatus == 2)
         {
            FMC_Scene.MC_Mask2.visible = true;
            FMC_Scene.MC_Mask3.visible = false;
            FMC_Scene.MC_Mask4.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_Got.visible = true;
         }
         else if(this.FBoxStatus == 3)
         {
            FMC_Scene.MC_Mask2.visible = false;
            FMC_Scene.MC_Mask3.visible = true;
            FMC_Scene.MC_Mask4.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_Got.visible = true;
         }
         else
         {
            FMC_Scene.MC_Mask2.visible = false;
            FMC_Scene.MC_Mask3.visible = false;
            FMC_Scene.MC_Mask4.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_Got.visible = true;
         }
      }
      
      protected function SEND_MESAAGE() : void
      {
         var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(CONST_MyActivity.MyActivity_ActivityIDid);
         _loc1_.Data.writeUnsignedInt(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ButtonOnClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ProcessorOnReturnGoldUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         if(!param1.currentTarget.buttonMode || this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc4_ = new Vector.<int>();
         PerformPacket_CS_AllReq(1,_loc4_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.Init();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:int = 0;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case 1:
               this.FBoxStatus = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED + this.FReturnGold + STRING_COMMON.ITEMNAME_Vouchers;
               ProcessorEffectText(_loc4_);
               this.UpdataView();
         }
      }
   }
}


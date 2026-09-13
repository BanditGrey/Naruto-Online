package Processors.Game.Lobby.Exercise.GodWelfare
{
   import Components.Pages.TUIPage;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.GodWelfare.TGodWelfare;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.TBaseBoxes;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerGodWelfare;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorGodWelfare extends TProcessorBaseActivity
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const LOG_COUNT:int = 3;
      
      protected static const REQ_GET_GIFT:int = 1;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FGodWelfare:TGodWelfare;
      
      protected var FUnstreamizerGodWelfare:TUnstreamizerGodWelfare;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TProcessorGodWelfare(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FGodWelfare = SLogicsCore.GodWelfare;
         this.FUnstreamizerGodWelfare = new TUnstreamizerGodWelfare();
         this.FBuyBoxDate = new Object();
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Box" + _loc1_];
            _loc2_ = 0;
            while(_loc2_ < BOX_COUNT)
            {
               _loc4_["MC_Icon" + _loc2_].MC_Icon.MC_Icon.gotoAndStop(_loc2_ + 1);
               TGameUtil.setButtonMode(_loc4_["MC_Icon" + _loc2_].BTN_Get,true);
               _loc4_["MC_Icon" + _loc2_].BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
               _loc4_["MC_Icon" + _loc2_].MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
               _loc4_["MC_Icon" + _loc2_].MC_Icon.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
               _loc2_++;
            }
            _loc1_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = LOG_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         FTF_Time = FMC_Scene.MC_Time.TF_Time;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(this.FGodWelfare.ActType == TGodWelfare.REFRESH_DAILY)
            {
               FTF_Time.text = TGameUtil.fomatTime(this.FGodWelfare.NextTime - STimingCore.GetServerTick());
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateBox();
         this.UpdateText();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:TBaseBoxes = null;
         var _loc8_:TBaseBox = null;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         this.FUIPage.TotalQuantity = this.FGodWelfare.ReturnList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc5_ = _loc1_ + this.FCurPage * LOG_COUNT;
            _loc9_ = FMC_Scene["MC_Box" + _loc1_];
            if(_loc5_ < this.FGodWelfare.ReturnList.length)
            {
               _loc9_.visible = true;
               _loc7_ = this.FGodWelfare.ReturnList[_loc5_];
               _loc9_.TF_Gold.text = _loc7_.Price + STRING_COMMON.ITEMNAME_Gold;
               _loc9_.TF_Return.text = _loc7_.Return + "%";
               _loc2_ = 0;
               while(_loc2_ < BOX_COUNT)
               {
                  _loc10_ = _loc9_["MC_Icon" + _loc2_];
                  if(_loc2_ < _loc7_.Items.length)
                  {
                     _loc10_.visible = true;
                     _loc8_ = _loc7_.Items[_loc2_];
                     if(_loc8_.Price == 0)
                     {
                        _loc10_.MC_Free.visible = true;
                        _loc10_.MC_Gold.visible = false;
                     }
                     else
                     {
                        _loc10_.MC_Free.visible = false;
                        _loc10_.MC_Gold.visible = true;
                        _loc10_.MC_Gold.TF_Text.text = TUtilityString.Format(this.FGodWelfare.DescListNew[2],_loc8_.Price);
                     }
                     if(_loc8_.Status == TBaseActivity.STATUS_CANNOTGET)
                     {
                        _loc10_.MC_Unable.visible = true;
                        _loc10_.BTN_Get.visible = false;
                        _loc10_.MC_Icon.gotoAndStop(1);
                     }
                     else if(_loc8_.Status == TBaseActivity.STATUS_CANGET)
                     {
                        _loc10_.MC_Unable.visible = false;
                        _loc10_.BTN_Get.visible = true;
                        TGameUtil.setButtonMode(_loc10_.BTN_Get,true);
                        _loc10_.MC_Icon.gotoAndPlay(1);
                     }
                     else
                     {
                        _loc10_.MC_Unable.visible = false;
                        _loc10_.BTN_Get.visible = true;
                        TGameUtil.setButtonMode(_loc10_.BTN_Get,false);
                        _loc10_.MC_Icon.gotoAndStop(1);
                     }
                  }
                  else
                  {
                     _loc10_.visible = false;
                  }
                  _loc2_++;
               }
            }
            else
            {
               _loc9_.visible = false;
            }
            _loc1_++;
         }
         if(this.FGodWelfare.ActType == TGodWelfare.REFRESH_DAILY)
         {
            FMC_Scene.MC_Time.visible = true;
         }
         else
         {
            FMC_Scene.MC_Time.visible = false;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         FMC_Scene.TF_Desc.text = this.FGodWelfare.DescListNew[1];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FGodWelfare.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FGodWelfare.EndTime) - 1) * 1000)));
         FMC_Scene.TF_TotalGold.text = this.FGodWelfare.TotalConsumeGold + STRING_COMMON.ITEMNAME_Gold;
         FMC_Scene.TF_Gold.text = this.FGodWelfare.ConsumeGold + STRING_COMMON.ITEMNAME_Gold;
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateBox();
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FGodWelfare)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            _loc3_ = int(String(param1.currentTarget.parent.parent.name).slice(7));
            this.ProcessorOnGetBoxUp(REQ_GET_GIFT,_loc3_ + 1,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.FGodWelfare)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            _loc3_ = int(String(param1.currentTarget.parent.parent.name).slice(7));
            ProcessorOnNewBoxOver(this.FGodWelfare.ReturnList[_loc3_].Items[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FGodWelfare;
         super.ProcessorOnOpenDesc();
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
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
         this.FIsOpen = true;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerGodWelfare.Unstreamize(_loc2_,this.FGodWelfare,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(this.FGodWelfare)
         {
            this.FGodWelfare.TotalConsumeGold = _loc2_.readUnsignedInt();
            this.FGodWelfare.ConsumeGold = _loc2_.readUnsignedInt();
            this.FGodWelfare.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FGodWelfare.CheckStatus());
            if(this.FIsOpen)
            {
               this.UpdateUI();
            }
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         ProcessorUnstreamActivityLog(this.FGodWelfare,_loc2_);
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
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
            case REQ_GET_GIFT:
               _loc17_ = _loc2_.readUnsignedInt() - 1;
               _loc18_ = _loc2_.readUnsignedInt() - 1;
               this.FGodWelfare.ReturnList[_loc17_].Items[_loc18_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < this.FGodWelfare.ReturnList[_loc17_].Items[_loc18_].Inventories.Count)
               {
                  _loc9_ = this.FGodWelfare.ReturnList[_loc17_].Items[_loc18_].Inventories.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               this.FGodWelfare.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FGodWelfare.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(11);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"消费%0金币");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"");
         TUtilityString.FlushUTF(_loc3_,"");
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(4);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc3_.writeInt(1);
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(7);
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(_loc1_ % 9 + 1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}


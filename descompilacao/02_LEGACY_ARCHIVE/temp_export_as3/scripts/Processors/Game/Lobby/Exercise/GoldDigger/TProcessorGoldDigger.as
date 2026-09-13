package Processors.Game.Lobby.Exercise.GoldDigger
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
   import Logics.Exercise.GoldDigger.TGoldDigger;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerGoldDigger;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorGoldDigger extends TProcessorBaseActivity
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const LOG_COUNT:int = 3;
      
      protected static const REQ_GET_GIFT:int = 1;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FGoldDigger:TGoldDigger;
      
      protected var FUnstreamizerGoldDigger:TUnstreamizerGoldDigger;
      
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
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      public function TProcessorGoldDigger(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FGoldDigger = SLogicsCore.GoldDigger;
         this.FUnstreamizerGoldDigger = new TUnstreamizerGoldDigger();
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowEquipDesc = new TProcessorWindowEquipDesc(this.Parent);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIShowItem = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Box" + _loc1_];
            _loc4_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc1_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.MC_Gift.BTN_Get,true);
         FMC_Scene.MC_Gift.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = LOG_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
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
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateBox();
         this.UpdateGift();
         this.UpdatePool();
         this.UpdateText();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Box" + _loc1_];
            _loc3_ = this.FGoldDigger.BoxList[_loc1_];
            _loc2_.TF_Desc0.text = TUtilityString.Format(this.FGoldDigger.DescListNew[4],_loc3_.Price);
            if(this.FGoldDigger.ReturnType == TBaseActivity.SWEET_TYPE_GOLD)
            {
               _loc2_.TF_Desc1.text = TUtilityString.Format(this.FGoldDigger.DescListNew[5],_loc3_.Max,STRING_COMMON.ITEMNAME_Gold);
               _loc2_.TF_Desc2.text = TUtilityString.Format(this.FGoldDigger.DescListNew[6],_loc3_.Count,STRING_COMMON.ITEMNAME_Gold);
            }
            else
            {
               _loc2_.TF_Desc1.text = TUtilityString.Format(this.FGoldDigger.DescListNew[5],_loc3_.Max,STRING_COMMON.ITEMNAME_Vouchers);
               _loc2_.TF_Desc2.text = TUtilityString.Format(this.FGoldDigger.DescListNew[6],_loc3_.Count,STRING_COMMON.ITEMNAME_Vouchers);
            }
            if(_loc1_ <= this.FGoldDigger.CurIndex)
            {
               _loc2_.filters = [];
               _loc2_.MC_Hammer.visible = true;
            }
            else
            {
               _loc2_.filters = [TGameUtil.GaryColorFilters];
               _loc2_.MC_Hammer.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FGoldDigger.Gift.Status;
         FMC_Scene.MC_Gift.TF_NeedGold.text = this.FGoldDigger.Gift.Price.toString();
         FMC_Scene.MC_Gift.TF_Desc.text = this.FGoldDigger.DescListNew[7];
         if(_loc1_ == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Gift.MC_Got.visible = false;
            FMC_Scene.MC_Gift.BTN_Get.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.MC_Gift.BTN_Get,false);
         }
         else if(_loc1_ == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Gift.MC_Got.visible = false;
            FMC_Scene.MC_Gift.BTN_Get.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.MC_Gift.BTN_Get,true);
         }
         else
         {
            FMC_Scene.MC_Gift.MC_Got.visible = true;
            FMC_Scene.MC_Gift.BTN_Get.visible = false;
         }
      }
      
      protected function UpdatePool() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         FMC_Scene.MC_Pool.TF_Gold.text = this.FGoldDigger.PoolGold.toString();
         FMC_Scene.MC_Pool.TF_Desc.text = this.FGoldDigger.DescListNew[8];
         this.FUIPage.TotalQuantity = this.FGoldDigger.NewsList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * LOG_COUNT;
            _loc3_ = FMC_Scene.MC_Pool["MC_Log" + _loc1_];
            if(_loc2_ < this.FGoldDigger.NewsList.length)
            {
               _loc3_.visible = true;
               _loc3_.TF_Server.text = this.FGoldDigger.NewsList[_loc2_].ServerID;
               _loc3_.TF_Name.text = this.FGoldDigger.NewsList[_loc2_].PlayerNick;
               _loc3_.TF_Gold.text = this.FGoldDigger.NewsList[_loc2_].Count.toString();
               _loc3_.TF_Date.text = TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(this.FGoldDigger.NewsList[_loc2_].GetTime) * 1000));
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         FMC_Scene.TF_Desc.text = this.FGoldDigger.DescListNew[1];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FGoldDigger.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FGoldDigger.EndTime) - 1) * 1000)));
         FMC_Scene.TF_RechargeGold.text = this.FGoldDigger.TotalRechargeGold.toString();
         FMC_Scene.TF_Desc1.text = this.FGoldDigger.DescListNew[3];
         if(this.FGoldDigger.CurIndex == BOX_COUNT - 1)
         {
            FMC_Scene.TF_Desc0.text = "";
         }
         else
         {
            _loc2_ = this.FGoldDigger.BoxList[this.FGoldDigger.CurIndex + 1].Price - this.FGoldDigger.TotalRechargeGold;
            FMC_Scene.TF_Desc0.text = TUtilityString.Format(this.FGoldDigger.DescListNew[2],_loc2_);
         }
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
         this.UpdatePool();
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FGoldDigger)
         {
            this.ProcessorOnGetBoxUp(REQ_GET_GIFT);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(this.FGoldDigger)
         {
            ProcessorOnNewBoxOver(this.FGoldDigger.Gift.Inventories);
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
         FProcessorWindowDesc.BaseActivity = this.FGoldDigger;
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
         this.FUnstreamizerGoldDigger.Unstreamize(_loc2_,this.FGoldDigger,null);
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
         if(this.FGoldDigger)
         {
            this.FGoldDigger.TotalRechargeGold = _loc2_.readUnsignedInt();
            this.FGoldDigger.CurIndex = _loc2_.readUnsignedInt() - 1;
            if(this.FGoldDigger.Gift)
            {
               this.FGoldDigger.Gift.Status = _loc2_.readInt();
            }
            this.FGoldDigger.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FGoldDigger.CheckStatus());
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
         ProcessorUnstreamActivityLog(this.FGoldDigger,_loc2_);
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
               this.FGoldDigger.Gift.Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < this.FGoldDigger.Gift.Inventories.Count)
               {
                  _loc9_ = this.FGoldDigger.Gift.Inventories.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               this.FGoldDigger.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FGoldDigger.CheckStatus());
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
         TUtilityString.FlushUTF(_loc3_,"距离下个矿山还差%0金币");
         TUtilityString.FlushUTF(_loc3_,"连续返还10天");
         TUtilityString.FlushUTF(_loc3_,"累计%0金币");
         TUtilityString.FlushUTF(_loc3_,"总返还%0%1");
         TUtilityString.FlushUTF(_loc3_,"每日返还%0%1");
         TUtilityString.FlushUTF(_loc3_,"价值9999金币");
         TUtilityString.FlushUTF(_loc3_,"预留1");
         TUtilityString.FlushUTF(_loc3_,"预留2");
         TUtilityString.FlushUTF(_loc3_,"预留3");
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


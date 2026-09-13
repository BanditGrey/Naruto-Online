package Processors.Game.Lobby.Exercise.ActivityB
{
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ActivityB.TActivityB;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerActivityB;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorActivityB extends TProcessorBaseActivity
   {
      
      public static const BOX_COUNT:int = 14;
      
      public static const TYPE_BUY_BOX:int = 1;
      
      public static const GET_BIG_BOX:int = 2;
      
      protected var FActivityB:TActivityB;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerActivityB:TUnstreamizerActivityB;
      
      protected var FNotOpenBoxVect:Vector.<TUIBaseBox>;
      
      protected var FOpenBoxVect:Vector.<TUIBaseBox>;
      
      protected var FCost:int;
      
      public function TProcessorActivityB(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FActivityB = SLogicsCore.ActivityB;
         this.FUnstreamizerActivityB = new TUnstreamizerActivityB();
         this.FNotOpenBoxVect = new Vector.<TUIBaseBox>(BOX_COUNT);
         this.FOpenBoxVect = new Vector.<TUIBaseBox>(BOX_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_OBX" + _loc1_]);
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            _loc5_.OnGetBox = this.ProcessorOnBoxUp;
            _loc5_.TipOnOver = this.ProcessorOnTipOver;
            _loc5_.TipOnOut = this.ProcessorOnTipOut;
            _loc5_.OnBuyBox = this.ProcessorOnBoxUp;
            this.FOpenBoxVect[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,1);
            FMC_Scene["MC_Box" + _loc1_].gotoAndStop(2);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Box" + _loc1_]);
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            _loc5_.OnGetBox = this.ProcessorOnBoxUp;
            _loc5_.TipOnOver = this.ProcessorOnTipOver;
            _loc5_.TipOnOut = this.ProcessorOnTipOut;
            _loc5_.OnBuyBox = this.ProcessorOnBoxUp;
            this.FNotOpenBoxVect[_loc1_] = _loc5_;
            _loc1_++;
         }
         FMC_Scene.MC_BigBox.addEventListener(MouseEvent.CLICK,this.ProcessorOnBigBoxUp);
         FMC_Scene.MC_BigBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBigBoxOver);
         FMC_Scene.MC_BigBox.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.LogicsPerform();
         if(FInitialized)
         {
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               if(this.FOpenBoxVect[_loc1_])
               {
                  this.FOpenBoxVect[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               if(this.FNotOpenBoxVect[_loc1_])
               {
                  this.FNotOpenBoxVect[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
         this.UpdateBigBox();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FActivityB.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FActivityB.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FActivityB.ActivityDesc;
         FMC_Scene.TF_Count.text = this.FActivityB.TotalMoney;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TUIBaseBox = null;
         var _loc6_:String = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            if(_loc1_ < this.FActivityB.BoxList.length)
            {
               _loc4_ = this.FActivityB.BoxList[_loc1_];
               if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  this.FOpenBoxVect[_loc1_].SetVisible(false);
                  this.FNotOpenBoxVect[_loc1_].SetVisible(true);
                  _loc5_ = this.FNotOpenBoxVect[_loc1_];
                  if(_loc4_.PicType == 1)
                  {
                     _loc5_.UpdateUI(_loc4_.Inventories);
                  }
                  else
                  {
                     _loc5_.UpdateUI(null);
                  }
               }
               else
               {
                  this.FNotOpenBoxVect[_loc1_].SetVisible(false);
                  this.FOpenBoxVect[_loc1_].SetVisible(true);
                  _loc5_ = this.FOpenBoxVect[_loc1_];
                  _loc5_.UpdateUI(_loc4_.Inventories);
               }
               if(_loc4_.IsHot == 1)
               {
                  _loc5_.SetMCIsVisible("MC_Hot",true);
               }
               else
               {
                  _loc5_.SetMCIsVisible("MC_Hot",false);
               }
               _loc5_.SetPriceText(_loc4_.Price.toString());
               _loc5_.SetDescText(0,_loc4_.Desc1);
               _loc5_.SetBuff(true,_loc4_.Desc2);
               if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc6_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ACTIVITY_B_STR_0,_loc4_.Count);
                  _loc5_.SetLimitText(_loc6_);
                  if(_loc4_.CurPrice == 0)
                  {
                     _loc5_.SetCurPriceText(STRING_BASEACTIVITY.FORMAT_ACTIVITY_B_STR_2);
                  }
                  else
                  {
                     _loc5_.SetCurPriceText(TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_TEXT2,_loc4_.CurPrice));
                  }
               }
               else
               {
                  if(_loc4_.BuyCount == 0)
                  {
                     _loc5_.MC_Tag.visible = true;
                     _loc5_.SetLimitText("");
                  }
                  else
                  {
                     _loc5_.MC_Tag.visible = false;
                     _loc6_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ACTIVITY_B_STR_1,_loc4_.BuyCount);
                     _loc5_.SetLimitText(_loc6_);
                  }
                  if(_loc4_.CurPrice == 0)
                  {
                     _loc5_.MC_Scene.MC_Free.visible = true;
                     _loc5_.MC_Scene.MC_Price.visible = false;
                  }
                  else
                  {
                     _loc5_.MC_Scene.MC_Free.visible = false;
                     _loc5_.MC_Scene.MC_Price.TF_Price.text = _loc4_.CurPrice.toString();
                  }
                  if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
                  {
                     _loc5_.MC_Got.visible = false;
                     _loc5_.MC_Bounght.visible = false;
                     if(_loc4_.CurPrice == 0)
                     {
                        _loc5_.BTN_Get.visible = true;
                        _loc5_.BTN_Buy.visible = false;
                     }
                     else
                     {
                        _loc5_.BTN_Get.visible = false;
                        _loc5_.BTN_Buy.visible = true;
                     }
                     if(_loc4_.BuyCount == 0)
                     {
                        TGameUtil.setButtonMode(_loc5_.BTN_Get,false);
                        TGameUtil.setButtonMode(_loc5_.BTN_Buy,false);
                     }
                     else
                     {
                        TGameUtil.setButtonMode(_loc5_.BTN_Get,true);
                        TGameUtil.setButtonMode(_loc5_.BTN_Buy,true);
                     }
                  }
                  else
                  {
                     _loc5_.BTN_Get.visible = false;
                     _loc5_.BTN_Buy.visible = false;
                     if(_loc4_.CurPrice == 0)
                     {
                        _loc5_.MC_Got.visible = true;
                        _loc5_.MC_Bounght.visible = false;
                     }
                     else
                     {
                        _loc5_.MC_Got.visible = false;
                        _loc5_.MC_Bounght.visible = true;
                     }
                  }
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBigBox() : void
      {
         if(this.FActivityB.BigBox.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_BigBox.filters = [TGameUtil.GaryColorFilters];
            FMC_Scene.MC_BigBox.MC_Click.visible = false;
            FMC_Scene.MC_BigBox.MC_Got.visible = false;
         }
         else if(this.FActivityB.BigBox.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_BigBox.filters = [];
            FMC_Scene.MC_BigBox.MC_Click.visible = true;
            FMC_Scene.MC_BigBox.MC_Got.visible = false;
         }
         else
         {
            FMC_Scene.MC_BigBox.filters = [];
            FMC_Scene.MC_BigBox.MC_Click.visible = false;
            FMC_Scene.MC_BigBox.MC_Got.visible = true;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         FIndex = int(String(param1.currentTarget.parent.name).slice(6));
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FActivityB.BoxList[FIndex].CurPrice == 0)
         {
            this.FBeClicked = true;
            _loc4_ = new Vector.<int>();
            _loc4_.push(FIndex + 1);
            PerformPacket_CS_AllReq(TYPE_BUY_BOX,_loc4_);
         }
         else if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = this.FActivityB.BoxList[FIndex].CurPrice;
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:Vector.<int> = null;
         if(this.FActivityB.IsCreditGoldEnough(this.FCost))
         {
            this.FBeClicked = true;
            _loc2_ = new Vector.<int>();
            _loc2_.push(FIndex + 1);
            PerformPacket_CS_AllReq(TYPE_BUY_BOX,_loc2_);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnBigBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:Vector.<int> = null;
         if(Boolean(this.FActivityB) && Boolean(this.FActivityB.BigBox) && this.FActivityB.BigBox.Status == TBaseActivity.STATUS_CANGET)
         {
            this.FBeClicked = true;
            _loc2_ = new Vector.<int>();
            _loc2_.push(1);
            PerformPacket_CS_AllReq(GET_BIG_BOX,_loc2_);
         }
      }
      
      protected function ProcessorOnBigBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(this.FActivityB) && Boolean(this.FActivityB.BigBox))
         {
            ProcessorOnNewBoxOver(this.FActivityB.BigBox.Inventories);
         }
      }
      
      protected function ProcessorOnTipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc2_ < this.FActivityB.BoxList.length)
         {
            ProcessorOnShowTip(this.FActivityB.BoxList[_loc2_].Desc3);
         }
      }
      
      protected function ProcessorOnTipOut() : void
      {
         ProcessorOnHideTip();
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
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorOnLoadInfoRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerActivityB.Unstreamize(_loc2_,this.FActivityB,null);
         ProcessorCheckEffect(FActivityID,this.FActivityB.CheckStatus());
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
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
         var _loc13_:Vector.<uint> = null;
         var _loc14_:uint = 0;
         var _loc15_:TBaseBox = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         switch(_loc7_)
         {
            case TYPE_BUY_BOX:
               _loc2_.readShort();
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FActivityB.BoxList[_loc5_].BuyCount = Math.max(0,this.FActivityB.BoxList[_loc5_].BuyCount - 1);
               this.FActivityB.TotalMoney = _loc2_.readUnsignedInt();
               this.FActivityB.BigBox.Status = _loc2_.readInt();
               this.FActivityB.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FActivityB.BoxList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FActivityB.CheckStatus());
               this.UpdateUI();
               break;
            case GET_BIG_BOX:
               this.FActivityB.BigBox.Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc8_ = this.FActivityB.BigBox.Inventories;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FActivityB.CheckStatus());
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
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([0,0,0,1]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"活动1");
         TUtilityString.FlushUTF(_loc3_,"活动2");
         TUtilityString.FlushUTF(_loc3_,"活动3");
         _loc3_.writeInt(14100001);
         _loc3_.writeInt(1);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeInt(_loc4_[_loc1_]);
            TUtilityString.FlushUTF(_loc3_,"aaa");
            TUtilityString.FlushUTF(_loc3_,"bbb");
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}


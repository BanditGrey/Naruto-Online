package Processors.Game.Lobby.Exercise.ActivityA
{
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ActivityA.TActivityA;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerActivityA;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorActivityA extends TProcessorBaseActivity
   {
      
      public static const BOX_COUNT:int = 4;
      
      public static const TYPE_GET_GIFT:int = 1;
      
      public static const TYPE_BUY_BOX:int = 2;
      
      protected var FBoxVect:Vector.<MovieClip>;
      
      protected var FActivityA:TActivityA;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerActivityA:TUnstreamizerActivityA;
      
      protected var FCost:int;
      
      public function TProcessorActivityA(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FActivityA = SLogicsCore.ActivityA;
         this.FUnstreamizerActivityA = new TUnstreamizerActivityA();
         this.FBoxVect = new Vector.<MovieClip>(BOX_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Box" + _loc1_];
            _loc4_.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnBoxUp);
            _loc4_.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc4_.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            this.FBoxVect[_loc1_] = _loc4_;
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
         FMC_Scene.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnGiftOut);
         FMC_Scene.BTN_Recharge.addEventListener(MouseEvent.CLICK,ProcessorOnRechargeUp);
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
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
         this.UpdateGift();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FActivityA.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FActivityA.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FActivityA.ActivityDesc;
         FMC_Scene.TF_Desc1.text = this.FActivityA.ActivityName;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxVect[_loc1_];
            if(_loc1_ < this.FActivityA.BoxList.length)
            {
               _loc4_ = this.FActivityA.BoxList[_loc1_];
               _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1);
               _loc3_.TF_Desc0.text = _loc4_.Desc1;
               _loc3_.TF_Desc1.text = _loc4_.Desc2;
               if(this.FActivityA.ReturnType == 0)
               {
                  _loc3_.TF_Desc2.text = STRING_COMMON.ITEMNAME_Vouchers;
               }
               else
               {
                  _loc3_.TF_Desc2.text = STRING_COMMON.ITEMNAME_Gold;
               }
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  TGameUtil.setButtonMode(_loc3_.BTN_Get,true);
                  FMC_Scene["MC_Tip" + _loc1_].visible = true;
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
                  FMC_Scene["MC_Tip" + _loc1_].visible = false;
               }
            }
            _loc1_++;
         }
         if(this.FActivityA.CheckIsBoxGet())
         {
            FMC_Scene.MC_Got.visible = true;
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               FMC_Scene["MC_Tip" + _loc1_].visible = false;
               _loc1_++;
            }
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
         }
      }
      
      protected function UpdateGift() : void
      {
         if(this.FActivityA.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Gift.MC_Got.visible = true;
            FMC_Scene.MC_Gift.MC_Box.gotoAndStop(1);
            FMC_Scene.MC_Gift.MC_GetBox.visible = false;
         }
         else if(this.FActivityA.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Gift.MC_Got.visible = false;
            FMC_Scene.MC_Gift.MC_GetBox.visible = true;
            FMC_Scene.MC_Gift.MC_Box.gotoAndPlay(1);
            FMC_Scene.MC_Gift.MC_GetBox.visible = true;
            FMC_Scene.MC_Gift.MC_GetBox.gotoAndPlay(1);
         }
         else
         {
            FMC_Scene.MC_Gift.MC_Got.visible = false;
            FMC_Scene.MC_Gift.MC_GetBox.visible = false;
            FMC_Scene.MC_Gift.MC_Box.gotoAndStop(1);
            FMC_Scene.MC_Gift.MC_GetBox.visible = false;
            FMC_Scene.MC_Gift.MC_GetBox.gotoAndStop(1);
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
         var _loc4_:int = 0;
         var _loc5_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         _loc4_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(this.FActivityA.BoxList[_loc4_].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         _loc5_ = new Vector.<int>();
         _loc5_.push(_loc4_ + 1);
         PerformPacket_CS_AllReq(TYPE_BUY_BOX,_loc5_);
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc2_ < this.FActivityA.BoxList.length)
         {
            _loc3_ = this.FActivityA.BoxList[_loc2_].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOver(this,_loc3_);
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(_loc2_ < this.FActivityA.BoxList.length)
         {
            _loc3_ = this.FActivityA.BoxList[_loc2_].Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOut(this,_loc3_);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         if(this.FActivityA.Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         this.FBeClicked = true;
         _loc4_ = new Vector.<int>();
         PerformPacket_CS_AllReq(TYPE_GET_GIFT,_loc4_);
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         if(Boolean(this.FActivityA.Inventories) && this.FActivityA.Inventories.Count > 0)
         {
            _loc2_ = this.FActivityA.Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOver(this,_loc2_);
         }
      }
      
      protected function ProcessorOnGiftOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         if(Boolean(this.FActivityA.Inventories) && this.FActivityA.Inventories.Count > 0)
         {
            _loc2_ = this.FActivityA.Inventories.GetInventoryByIndex(0);
            UIComponentsHintOnOut(this,_loc2_);
         }
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
         this.FUnstreamizerActivityA.Unstreamize(_loc2_,this.FActivityA,null);
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
            case TYPE_GET_GIFT:
               this.FActivityA.Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FActivityA.Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FActivityA.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_BUY_BOX:
               _loc2_.readShort();
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FActivityA.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FActivityA.BoxList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FActivityA.CheckStatus());
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
         _loc2_ = param1.Data;
         _loc2_.readShort();
         this.FActivityA.Status = _loc2_.readInt();
         _loc4_ = 0;
         while(_loc4_ < this.FActivityA.BoxList.length)
         {
            this.FActivityA.BoxList[_loc4_].Status = _loc2_.readInt();
            _loc4_++;
         }
         ProcessorCheckEffect(FActivityID,this.FActivityA.CheckStatus());
         if(Boolean(FMC_Scene) && this.visible)
         {
            this.UpdateUI();
         }
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


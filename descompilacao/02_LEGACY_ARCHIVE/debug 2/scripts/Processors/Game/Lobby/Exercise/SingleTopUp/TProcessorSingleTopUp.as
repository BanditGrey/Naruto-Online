package Processors.Game.Lobby.Exercise.SingleTopUp
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.SingleTopUp.TSingleTopUp;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerSingleTopUp;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorSingleTopUp extends TProcessorBaseActivity
   {
      
      public static const BOX_COUNT:int = 10;
      
      public static const TYPE_GET_GIFT:int = 1;
      
      public static const TYPE_BUY_BOX:int = 2;
      
      protected var FBoxVect:Vector.<MovieClip>;
      
      protected var FSingleTopUp:TSingleTopUp;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerSingleTopUp:TUnstreamizerSingleTopUp;
      
      protected var FCost:int;
      
      public function TProcessorSingleTopUp(param1:TUIComponent, param2:TLobbyParameters, param3:int)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FSingleTopUp = SLogicsCore.SingleTopUp;
         this.FUnstreamizerSingleTopUp = new TUnstreamizerSingleTopUp();
         this.FBoxVect = new Vector.<MovieClip>(BOX_COUNT);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<uint> = null;
         _loc3_ = CONST_BASEACTIVITY.ACTIVELIST_THIRD_TYPE;
         _loc2_ = _loc3_.indexOf(FActivityID);
         if(_loc2_ != -1)
         {
            SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BASEACTIVITY.ACTIVELIST_THIRD_RESOURCESID[_loc2_]);
         }
         else
         {
            _loc1_ = CONST_BASEACTIVITY.NEW_ACTIVELIST_TYPE.indexOf(FActivityID);
            SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BASEACTIVITY.NEW_ACTIVELIST_RESOURCESID[_loc1_]);
         }
         super.ResourcesPerform_UIRequest();
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
            _loc4_.MC_HotOrNew.visible = false;
            _loc4_.MC_Get.visible = false;
            _loc4_.BTN_Recharge.visible = true;
            _loc4_.MC_Icon.gotoAndStop(_loc1_ + 1);
            TGameUtil.setButtonMode(_loc4_.BTN_Recharge,true);
            _loc4_.BTN_Recharge.addEventListener(MouseEvent.CLICK,ProcessorOnRechargeUp);
            this.FBoxVect[_loc1_] = _loc4_;
            _loc1_++;
         }
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
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FSingleTopUp.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FSingleTopUp.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FSingleTopUp.DescListNew[0];
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
            if(_loc1_ < this.FSingleTopUp.BoxList.length)
            {
               if(_loc3_.MC_Mask)
               {
                  _loc3_.MC_Mask.visible = false;
               }
               _loc4_ = this.FSingleTopUp.BoxList[_loc1_];
               _loc3_.TF_Desc0.text = _loc4_.DescListNew[0];
               _loc3_.TF_Desc1.text = _loc4_.ReturnMoney;
               if(_loc4_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc3_.MC_Get.visible = true;
                  _loc3_.BTN_Recharge.visible = false;
               }
               else
               {
                  _loc3_.MC_Get.visible = false;
                  _loc3_.BTN_Recharge.visible = true;
               }
               if(_loc4_.IsHot == TBaseActivity.IS_HOT)
               {
                  _loc3_.MC_HotOrNew.visible = true;
               }
               else if(_loc4_.IsHot == TBaseActivity.IS_NOHOT)
               {
                  _loc3_.MC_HotOrNew.visible = false;
               }
            }
            else if(_loc3_.MC_Mask)
            {
               _loc3_.MC_Mask.visible = true;
               _loc3_.MC_HotOrNew.visible = false;
            }
            _loc1_++;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
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
         this.FUnstreamizerSingleTopUp.Unstreamize(_loc2_,this.FSingleTopUp,null);
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
               this.FSingleTopUp.Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FSingleTopUp.Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FSingleTopUp.CheckStatus());
               this.UpdateUI();
               break;
            case TYPE_BUY_BOX:
               _loc2_.readShort();
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FSingleTopUp.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FSingleTopUp.BoxList[_loc5_].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FSingleTopUp.CheckStatus());
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
         var _loc9_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc7_ = _loc2_.readInt();
         _loc9_ = _loc2_.readInt();
         if(Boolean(this.FSingleTopUp) && this.FSingleTopUp.BoxList.length > 0)
         {
            this.FSingleTopUp.BoxList[_loc7_ - 1].Status = _loc9_;
            ProcessorCheckEffect(FActivityID,this.FSingleTopUp.CheckStatus());
         }
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


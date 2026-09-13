package Processors.Game.Lobby.Exercise.VipTreasure
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TVipConfig;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.VipTreasure.TVipTreasure;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerVipTreasure;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorVipTreasure extends TProcessorBaseActivity
   {
      
      protected static const BOX_COUNT:int = 10;
      
      protected static const REWARD_COUNT:int = 4;
      
      protected static const REQ_TYPE_FIND_TREASURE:int = 1;
      
      protected static const REQ_TYPE_GET_REWARD:int = 2;
      
      protected static const BEGIN_X:Vector.<int> = Vector.<int>([92,130,189,251,321,384,441,455,396,336]);
      
      protected static const BEGIN_Y:Vector.<int> = Vector.<int>([183,230,253,271,282,272,240,170,146,133]);
      
      protected static const END_X:Vector.<int> = Vector.<int>([134,220,313,401]);
      
      protected static const END_Y:Vector.<int> = Vector.<int>([376,376,376,376]);
      
      protected static const RESULT_LOSE:int = 0;
      
      protected static const RESULT_WIN:int = 1;
      
      protected var FVipTreasure:TVipTreasure;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FMaxVipLv:int;
      
      protected var FTotalFrame:int;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FRewardList:Vector.<MovieClip>;
      
      protected var FUnstreamizerVipTreasure:TUnstreamizerVipTreasure;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FArticleBins:TBins;
      
      protected var FVipConfigBins:TBins;
      
      protected var FInitX:int;
      
      protected var FInitY:int;
      
      protected var FMC_Effect:MovieClip;
      
      public function TProcessorVipTreasure(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FVipTreasure = SLogicsCore.VipTreasure;
         this.FUnstreamizerVipTreasure = new TUnstreamizerVipTreasure();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FRewardList = new Vector.<MovieClip>(REWARD_COUNT);
         this.FOverlayerBox = new TOverlayerBox(this.Parent);
         this.FOverlayerBox.Visible = false;
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
            this.FBoxList[_loc1_] = _loc4_;
            _loc4_.buttonMode = true;
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Reward" + _loc1_];
            this.FRewardList[_loc1_] = _loc4_;
            _loc4_.buttonMode = true;
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetRewardUp);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRewardOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnRewardOut);
            _loc1_++;
         }
         this.FMC_Effect = FMC_Scene.MC_Effect;
         this.FMC_Effect.visible = false;
         this.FArticleBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FVipConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_VipConfig);
         this.FMaxVipLv = this.FVipConfigBins.Count;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerBox);
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
         var _loc2_:MovieClip = null;
         super.LogicsPerform();
         if(FInitialized)
         {
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
         this.UpdateReward();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:TCharacter = null;
         var _loc2_:TVipConfig = null;
         var _loc3_:TVipConfig = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc1_ = SLogicsCore.Character;
         _loc5_ = _loc1_.VipData.VipExp;
         _loc2_ = this.FVipConfigBins.GetDatebaseByIdentifier(_loc1_.VipLevel + 1) as TVipConfig;
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FVipTreasure.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FVipTreasure.EndTime) - 1) * 1000)));
         FTF_Desc.text = this.FVipTreasure.ActivityDesc;
         if(_loc1_.VipLevel < this.FMaxVipLv - 1)
         {
            _loc4_ = uint(_loc2_.ChargeCount);
            _loc6_ = _loc4_ - _loc5_;
            FMC_Scene.TF_VipDesc.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_NEXT_LEVEL_NEED_RECHARGE_GOLD,_loc1_.VipLevel,int(_loc6_ / 2),_loc1_.VipLevel + 1);
         }
         else
         {
            FMC_Scene.TF_VipDesc.text = STRING_BASEACTIVITY.FORMAT_MAX_VIP_LEVEL;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TCharacter = null;
         _loc3_ = SLogicsCore.Character;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = this.FBoxList[_loc1_];
            _loc2_.TF_VipLevel.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_VIP_LEVEL,_loc1_ + 1);
            if(this.FVipTreasure.BoxList[_loc1_].Status == TBaseActivity.STATUS_GETED)
            {
               _loc2_.MC_Got.visible = true;
               _loc2_.MC_Icon.visible = true;
               _loc2_.MC_Icon.gotoAndStop(1);
            }
            else if(this.FVipTreasure.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.MC_Got.visible = false;
               _loc2_.MC_Icon.visible = true;
               _loc2_.MC_Icon.gotoAndPlay(1);
            }
            else
            {
               _loc2_.MC_Got.visible = false;
               _loc2_.MC_Icon.visible = false;
            }
            if(_loc3_.VipLevel == _loc1_ + 1 && this.FVipTreasure.BoxList[_loc1_].Status != TBaseActivity.STATUS_GETED)
            {
               _loc2_.MC_Tip.visible = true;
               _loc2_.MC_Tip.gotoAndPlay(1);
            }
            else
            {
               _loc2_.MC_Tip.visible = false;
            }
            _loc1_++;
         }
         if(this.FVipTreasure.BoxList[this.FVipTreasure.BoxList.length - 1].Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_End.visible = true;
         }
         else
         {
            FMC_Scene.MC_End.visible = false;
         }
      }
      
      protected function UpdateReward() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            _loc2_ = this.FRewardList[_loc1_];
            _loc2_.MC_Icon.gotoAndStop(_loc1_ + 1);
            if(this.FVipTreasure.RewardList[_loc1_].Status == TBaseActivity.STATUS_GETED)
            {
               _loc2_.gotoAndStop(1);
               _loc2_.MC_Effect.visible = false;
            }
            else if(this.FVipTreasure.RewardList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.gotoAndPlay(1);
               _loc2_.MC_Effect.visible = true;
            }
            else
            {
               _loc2_.gotoAndStop(1);
               _loc2_.MC_Effect.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         if(this.FIsPlaying || this.FBeClicked)
         {
            ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT);
            return;
         }
         _loc3_ = int(String(param1.currentTarget.name).slice(6));
         if(!this.FVipTreasure.BoxList[_loc3_] || this.FVipTreasure.BoxList[_loc3_].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         FIndex = _loc3_;
         _loc4_ = new Vector.<int>();
         _loc4_.push(FIndex + 1);
         PerformPacket_CS_AllReq(REQ_TYPE_FIND_TREASURE,_loc4_);
      }
      
      protected function ProcessorOnGetRewardUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<int> = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         if(this.FVipTreasure.RewardList[_loc2_].Status != TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         FIndex = _loc2_;
         _loc3_ = new Vector.<int>();
         _loc3_.push(FIndex + 1);
         PerformPacket_CS_AllReq(REQ_TYPE_GET_REWARD,_loc3_);
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         this.FOverlayerBox.Context = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         if(this.FVipTreasure.RewardList[_loc2_])
         {
            this.FOverlayerBox.Context = this.FVipTreasure.RewardList[_loc2_].Inventories;
            this.FOverlayerBox.Render(FUICore.MouseCoordinate);
            this.FOverlayerBox.Show();
         }
      }
      
      protected function ProcessorOnRewardOut(param1:MouseEvent) : void
      {
         this.FOverlayerBox.Hide();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      public function PlayMovie(param1:int, param2:int) : void
      {
         var _loc3_:String = null;
         if(this.FIsPlaying)
         {
            ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT);
            return;
         }
         if(this.FMC_Effect)
         {
            this.FMC_Effect.visible = true;
            this.FIsPlaying = true;
            this.FMC_Effect.gotoAndPlay(1);
            TweenUtil.to(this.FMC_Effect,1200,{"onComplete":this.MovieEnd});
         }
      }
      
      public function MovieEnd() : void
      {
         this.FMC_Effect.visible = false;
         this.FIsPlaying = false;
         this.UpdateUI();
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
         this.FUnstreamizerVipTreasure.Unstreamize(_loc2_,this.FVipTreasure,null);
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
         _loc2_ = param1.Data;
         if(this.FVipTreasure.RewardList[0])
         {
            _loc2_.readUnsignedShort();
            ProcessorCheckEffect(FActivityID,this.FVipTreasure.CheckStatus());
            if(this.visible == true)
            {
               this.UpdateUI();
            }
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
         var _loc15_:int = 0;
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
            case REQ_TYPE_FIND_TREASURE:
               _loc15_ = _loc2_.readInt();
               this.FVipTreasure.BoxList[FIndex].Status = TBaseActivity.STATUS_GETED;
               if(_loc15_ == RESULT_LOSE)
               {
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_NOT_FIND_Treasure);
               }
               else
               {
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_FIND_Treasure);
                  this.FVipTreasure.RewardList[_loc15_ - 1].Status = TBaseActivity.STATUS_CANGET;
               }
               ProcessorCheckEffect(FActivityID,this.FVipTreasure.CheckStatus());
               if(_loc15_ > 0)
               {
                  this.PlayMovie(FIndex,_loc15_ - 1);
               }
               else
               {
                  this.UpdateUI();
               }
               break;
            case REQ_TYPE_GET_REWARD:
               _loc5_ = _loc2_.readInt();
               this.FVipTreasure.RewardList[_loc5_ - 1].Status = TBaseActivity.STATUS_GETED;
               _loc8_ = this.FVipTreasure.RewardList[_loc5_ - 1].Inventories;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.Count)
               {
                  _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FVipTreasure.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1421571200);
         TUtilityString.FlushUTF(_loc3_,"VIP寻宝");
         _loc3_.writeShort(10);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc2_ + _loc1_);
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(20);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}


package Processors.Game.Lobby.CrossServerWar
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.THero;
   import Logics.CrossServerWar.TChallengePlayer;
   import Logics.CrossServerWar.TChallengePlayers;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.DatebaseVO.VO.TGSPVP_Reward;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.NijiaStar.Components.TUIHeroHead;
   import Resources.Constants.CONST_CROSSSERVERWAR;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorWindowChallengeLadder extends TProcessorLobbyWindow
   {
      
      protected static const LEVELFLOORVEC:Array = [[0,1,2,3,4,5],[6,7,8,9,10],[11,12,13,14],[15,16],[17]];
      
      protected const CAPACITY_ChallengePlayers:uint = 18;
      
      protected const CAPACITY_Boxes:uint = 5;
      
      protected var FBTN_Back:MovieClip;
      
      protected var FBoxes:Vector.<MovieClip>;
      
      protected var FStepChallengeHeroHeads:Vector.<TUIHeroHead>;
      
      protected var FStepChallengePlayers:TChallengePlayers;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FGSPVP_RewardBins:TBins;
      
      protected var FGSPVP_Reward:TGSPVP_Reward;
      
      protected var FBoxOnMove:Function;
      
      protected var FBoxOnOut:Function;
      
      protected var FUIComponentsOnOver:Function;
      
      protected var FUIComponentsOnOut:Function;
      
      public function TProcessorWindowChallengeLadder(param1:TUIComponent)
      {
         super(param1);
         this.FStepChallengeHeroHeads = new Vector.<TUIHeroHead>(this.CAPACITY_ChallengePlayers);
         this.FStepChallengePlayers = SLogicsCore.StepChallengePlayers;
         this.FBoxes = new Vector.<MovieClip>(this.CAPACITY_Boxes);
         this.FEliteRecord = SLogicsCore.EliteRecord;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_CROSSSERVERWAR.RESOURCESID_Swf_CrossServerWar);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Sprite = null;
         var _loc4_:TUIHeroHead = null;
         var _loc5_:MovieClip = null;
         TGameUtil.AddWindowMask(this,-123,-53);
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_CROSSSERVERWAR.RESOURCE_ClassName_MC_ChallengeLadder) as Sprite;
         addChild(_loc3_);
         _loc2_ = this.CAPACITY_ChallengePlayers;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUIHeroHead(this);
            _loc4_.Resource = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_MC_Hero + _loc1_];
            _loc4_.Init();
            _loc4_.OnOver = this.ProcessorUIHeroHeadOnOver;
            _loc4_.OnOut = this.ProcessorUIHeroHeadOnOut;
            this.FStepChallengeHeroHeads[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FBTN_Back = _loc3_[CONST_CROSSSERVERWAR.RESOURCE_Link_BTN_Back];
         TGameUtil.setButtonMode(this.FBTN_Back,true);
         _loc2_ = this.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = _loc3_["MC_Box_" + _loc1_] as MovieClip;
            this.FBoxes[_loc1_] = _loc5_;
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.MCBoxOnMove,false,0,true);
            _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.MCBoxOnOut,false,0,true);
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Back.addEventListener(MouseEvent.CLICK,this.CloseOnClick,false,0,true);
         this.FGSPVP_RewardBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GSPVP_Reward) as TBins;
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateStepChallengeHeroHeadInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         var _loc4_:TChallengePlayer = null;
         _loc2_ = this.CAPACITY_ChallengePlayers;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FStepChallengeHeroHeads[_loc1_];
            if(_loc1_ >= this.FStepChallengePlayers.Count)
            {
               _loc3_.ShowMC_HuiTai = true;
            }
            else
            {
               _loc4_ = this.FStepChallengePlayers.GetChallengePlayerByIndex(_loc1_);
               _loc3_.Context = _loc4_;
               _loc3_.ShowMC_HuiTai = false;
               _loc3_.Update();
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBoxStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TChallengePlayer = null;
         _loc7_ = -1;
         _loc5_ = -1;
         _loc2_ = uint(this.FStepChallengePlayers.Count);
         _loc1_ = 0;
         loop0:
         while(_loc1_ < _loc2_)
         {
            _loc8_ = this.FStepChallengePlayers.GetChallengePlayerByIndex(_loc1_);
            if(!_loc8_.IsDefeated)
            {
               _loc6_ = _loc1_;
               _loc4_ = LEVELFLOORVEC.length;
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  _loc7_ = int(LEVELFLOORVEC[_loc3_].indexOf(_loc6_));
                  if(_loc7_ > -1)
                  {
                     _loc5_ = _loc3_;
                     break loop0;
                  }
                  _loc3_++;
               }
            }
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc5_ != -1 && _loc5_ <= _loc1_)
            {
               break;
            }
            this.FBoxes[_loc1_].gotoAndStop(2);
            _loc1_++;
         }
      }
      
      protected function CloseOnClick(param1:MouseEvent) : void
      {
         TweenUtil.to(this,300,{
            "x":1128,
            "y":53,
            "onComplete":this.CallBackFuc
         });
      }
      
      protected function CallBackFuc() : void
      {
         this.Visible = false;
      }
      
      protected function ProcessorUIHeroHeadOnClick(param1:Object, param2:TChallengePlayer) : void
      {
         var _loc3_:THero = null;
         _loc3_ = param2.TargetHeros.GetHeroByIndex(0);
      }
      
      protected function ProcessorUIHeroHeadOnOver(param1:Object, param2:TChallengePlayer) : void
      {
         if(this.FUIComponentsOnOver != null)
         {
            this.FUIComponentsOnOver(this,param2);
         }
      }
      
      protected function ProcessorUIHeroHeadOnOut(param1:Object, param2:TChallengePlayer) : void
      {
         if(this.FUIComponentsOnOut != null)
         {
            this.FUIComponentsOnOut(this,param2);
         }
      }
      
      protected function MCBoxOnMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc4_ = parseInt(param1.currentTarget.name.split("_")[2]);
         _loc3_ = uint(this.FGSPVP_RewardBins.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FGSPVP_Reward = this.FGSPVP_RewardBins.GetDatebaseByIndex(_loc2_) as TGSPVP_Reward;
            if(this.FGSPVP_Reward.Group == this.FEliteRecord.GroupLevel && this.FGSPVP_Reward.Floor == _loc4_ + 1)
            {
               break;
            }
            _loc2_++;
         }
         if(this.FBoxOnMove != null)
         {
            this.FBoxOnMove(this,this.FGSPVP_Reward);
         }
      }
      
      protected function MCBoxOnOut(param1:MouseEvent) : void
      {
         if(this.FBoxOnOut != null)
         {
            this.FBoxOnOut(this);
         }
      }
      
      public function get UIComponentsOnOver() : Function
      {
         return this.FUIComponentsOnOver;
      }
      
      public function set UIComponentsOnOver(param1:Function) : void
      {
         this.FUIComponentsOnOver = param1;
      }
      
      public function get UIComponentsOnOut() : Function
      {
         return this.FUIComponentsOnOut;
      }
      
      public function set UIComponentsOnOut(param1:Function) : void
      {
         this.FUIComponentsOnOut = param1;
      }
      
      public function get BoxOnMove() : Function
      {
         return this.FBoxOnMove;
      }
      
      public function set BoxOnMove(param1:Function) : void
      {
         this.FBoxOnMove = param1;
      }
      
      public function get BoxOnOut() : Function
      {
         return this.FBoxOnOut;
      }
      
      public function set BoxOnOut(param1:Function) : void
      {
         this.FBoxOnOut = param1;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateStepChallengeHeroHeadInfo();
         this.UpdateBoxStatus();
      }
   }
}


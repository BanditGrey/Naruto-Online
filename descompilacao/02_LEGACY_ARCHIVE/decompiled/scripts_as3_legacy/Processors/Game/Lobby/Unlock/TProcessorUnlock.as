package Processors.Game.Lobby.Unlock
{
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Affairs.*;
   import Logics.Characters.*;
   import Logics.Quests.*;
   import Logics.Spaces.LogicsSpace;
   import Logics.Streamization.Unlock.*;
   import Logics.Unlocks.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.text.*;
   import flash.utils.*;
   import ghostcat.operation.*;
   import ghostcat.util.easing.*;
   
   use namespace LogicsSpace;
   
   public class TProcessorUnlock extends TProcessorLobbyWindows
   {
      
      protected static const AFFAIRID_UnlockStart:uint = 267387120;
      
      public static const SCENEPOSITION_MAINCITY:int = CONST_COMMON.SCENEPOSITION_MAINCITY;
      
      public static const PLOT_MODE_None:int = CONST_PLOT.PLOT_MODE_None;
      
      public static const POSITION_Activity:uint = CONST_SHORTCUTS.POSITION_Activity;
      
      public static const POSITION_Function:uint = CONST_SHORTCUTS.POSITION_Function;
      
      public static const UNLOCK_Condition_Unlocked:uint = CONST_UNLOCK.UNLOCK_Condition_Unlocked;
      
      public static const UNLOCK_Condition_Quest:uint = CONST_UNLOCK.UNLOCK_Condition_Quest;
      
      public static const UNLOCK_Condition_Level:uint = CONST_UNLOCK.UNLOCK_Condition_Level;
      
      public static const RESOURCE_ClassName_Activity_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Btns;
      
      public static const RESOURCE_ClassName_Function_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_Function_Btns;
      
      protected var FUnstreamizerUnlocks:TUnstreamizerUnlocks;
      
      protected var FUnlocks:TUnlocks;
      
      protected var FChracter:TCharacter;
      
      protected var FMainQuestComplete:TQuests;
      
      protected var FUnlockEffects:Vector.<RepeatOper>;
      
      protected var FUnlockSteps:Vector.<Function>;
      
      protected var FTweenOperStartFadeIn:TweenOper;
      
      protected var FTweenOperStartFadeOut:TweenOper;
      
      protected var FTweenOperStopFadeIn:TweenOper;
      
      protected var FTweenOperStopFadeOut:TweenOper;
      
      protected var FTweenOperEndFadeIn:TweenOper;
      
      protected var FTweenOperEndFadeOut:TweenOper;
      
      protected var FTweenOperMoveIn:TweenOper;
      
      protected var FTweenOperMoveOut:TweenOper;
      
      protected var FRepeatOper:RepeatOper;
      
      protected var FMC_Unlock:Sprite;
      
      protected var FTF_Desc:TextField;
      
      protected var FMC_MountPointActivity:Sprite;
      
      protected var FMC_MountPointFunction:Sprite;
      
      protected var FMC_SubstrateActivity:Sprite;
      
      protected var FMC_SubstrateFunction:Sprite;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FMC_Icon:Sprite;
      
      protected var FUnlock:TUnlock;
      
      protected var FButton:SimpleButton;
      
      protected var FBounds:TBounds;
      
      protected var FCoordinate:TCoordinate;
      
      protected var FUnlockActivityIndex:int;
      
      protected var FUnlockFunctionIndex:int;
      
      protected var FIsUnlockCompleted:Boolean;
      
      protected var FIsFirst:Boolean;
      
      protected var FIsStartStep:Boolean;
      
      protected var FIsCheckUnlockState:Boolean;
      
      protected var FIsUnlockResidual:Boolean;
      
      protected var FOnUpdateShortcutsState:Function;
      
      protected var FOnUnlockNotification:Function;
      
      protected var FOnUnlockedNotification:Function;
      
      public function TProcessorUnlock(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerUnlocks = new TUnstreamizerUnlocks();
         this.FUnlocks = SLogicsCore.Unlocks;
         this.FUnlockEffects = new Vector.<RepeatOper>();
         this.FUnlockSteps = new Vector.<Function>();
         this.FChracter = SLogicsCore.Character;
         this.FMainQuestComplete = this.FChracter.MainQuestComplete;
         mouseEnabled = false;
         this.FIsUnlockCompleted = false;
         this.FIsFirst = true;
         this.FIsCheckUnlockState = false;
         this.FIsUnlockResidual = true;
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_UNLOCK.TEXTURESID_UNLOCK);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TBins = null;
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         this.FUnstreamizerUnlocks.Unstreamize(null,this.FUnlocks,_loc1_);
         this.FMC_Unlock = TUtilityReflection.CreateDisplayObjectInstance(CONST_UNLOCK.RESOURCE_ClassName_MC_Unlock) as Sprite;
         addChild(this.FMC_Unlock);
         this.FTF_Desc = this.FMC_Unlock[CONST_UNLOCK.RESOURCE_Link_TF_Desc];
         this.FMC_SubstrateActivity = this.FMC_Unlock[CONST_UNLOCK.RESOURCE_Link_MC_SubstrateActivity];
         this.FMC_MountPointActivity = this.FMC_SubstrateActivity[CONST_UNLOCK.RESOURCE_Link_MC_MountPointActivity];
         this.FMC_SubstrateFunction = this.FMC_Unlock[CONST_UNLOCK.RESOURCE_Link_MC_SubstrateFunction];
         this.FMC_MountPointFunction = this.FMC_SubstrateFunction[CONST_UNLOCK.RESOURCE_Link_MC_MountPointFunction];
         this.FMC_EffectLeft = this.FMC_Unlock[CONST_UNLOCK.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = this.FMC_Unlock[CONST_UNLOCK.RESOURCE_Link_MC_EffectRight];
         this.ConstructTweens();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Unlock.x = (CONST_COMMON.STAGE_Width - this.FMC_Unlock.width) / 2;
         this.FMC_Unlock.y = (CONST_COMMON.STAGE_Height - this.FMC_Unlock.height) / 2;
         this.FMC_EffectLeft.gotoAndStop(1);
         this.FMC_EffectRight.gotoAndStop(1);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ConstructTweens() : void
      {
         this.FRepeatOper = new RepeatOper();
         this.FTweenOperStartFadeIn = new TweenOper();
         this.FTweenOperStartFadeOut = new TweenOper();
         this.FTweenOperStopFadeIn = new TweenOper();
         this.FTweenOperStopFadeOut = new TweenOper();
         this.FTweenOperEndFadeIn = new TweenOper();
         this.FTweenOperEndFadeOut = new TweenOper();
         this.FTweenOperMoveIn = new TweenOper();
         this.FTweenOperMoveOut = new TweenOper();
         this.FTweenOperStartFadeIn.duration = 10;
         this.FTweenOperStartFadeOut.duration = 250;
         this.FTweenOperStopFadeIn.duration = 350;
         this.FTweenOperStopFadeOut.duration = 650;
         this.FTweenOperEndFadeIn.duration = 10;
         this.FTweenOperEndFadeOut.duration = 350;
         this.FTweenOperMoveIn.duration = 10;
         this.FTweenOperMoveOut.duration = 750;
         this.FRepeatOper.loop = 1;
         this.FRepeatOper.children = [this.FTweenOperStartFadeIn,this.FTweenOperStartFadeOut,this.FTweenOperStopFadeIn,this.FTweenOperStopFadeOut,this.FTweenOperEndFadeIn,this.FTweenOperEndFadeOut,this.FTweenOperMoveIn,this.FTweenOperMoveOut];
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FIsUnlockResidual)
         {
            this.LogicsPerform_CheckUnlock();
            this.LogicsPerform_UnlockStep();
            this.LogicsPerform_UnlockEffect();
         }
      }
      
      override protected function AffairRegisterRoutines() : void
      {
         super.AffairRegisterRoutines();
         FAffairRoutines.Register(AFFAIRID_UnlockStart,this.AffairPerform_UnlockStart);
      }
      
      protected function LogicsPerform_CheckUnlock() : void
      {
         if(this.FIsCheckUnlockState)
         {
            this.FIsUnlockCompleted = this.ProcessorUnlockState();
            if(this.FIsUnlockCompleted)
            {
               this.FUnlockSteps.push(this.ProcessorUnlockStep);
            }
         }
      }
      
      protected function LogicsPerform_UnlockStep() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Function = null;
         _loc1_ = this.CheckUnlockState();
         if(!_loc1_)
         {
            return;
         }
         if(this.FUnlockSteps.length != 0)
         {
            _loc2_ = this.FUnlockSteps.pop();
            _loc2_();
         }
      }
      
      protected function LogicsPerform_UnlockEffect() : void
      {
         var _loc1_:RepeatOper = null;
         if(this.FUnlockEffects.length != 0)
         {
            _loc1_ = this.FUnlockEffects.pop();
            _loc1_.execute();
         }
      }
      
      protected function ProcessorUnlockState() : Boolean
      {
         return this.CheckShortcutsUnlockState();
      }
      
      protected function CheckShortcutsUnlockState() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUnlock = null;
         var _loc4_:Boolean = false;
         var _loc5_:TQuest = null;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         _loc7_ = false;
         _loc2_ = this.FUnlocks.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUnlocks.GetUnlockByIndex(_loc1_);
            if(_loc3_.UnlockState == TUnlock.UNLOCKSTATE_Unlock)
            {
               _loc4_ = false;
               switch(_loc3_.UnlockCondition)
               {
                  case UNLOCK_Condition_Unlocked:
                     _loc4_ = true;
                     break;
                  case UNLOCK_Condition_Quest:
                     _loc5_ = this.FMainQuestComplete.GetQuestByIdentifier(_loc3_.UnlockValue);
                     if(_loc5_ != null)
                     {
                        if(_loc3_.UnlockValue == _loc5_.Identifier)
                        {
                           _loc4_ = true;
                        }
                     }
                     break;
                  case UNLOCK_Condition_Level:
                     _loc6_ = int(this.FChracter.GetMainLevel());
                     if(_loc6_ >= _loc3_.UnlockValue)
                     {
                        _loc4_ = true;
                     }
               }
               if(_loc4_)
               {
                  _loc7_ = _loc4_;
                  if(!this.FIsFirst)
                  {
                     _loc3_.UnlockState = TUnlock.UNLOCKSTATE_Unlocking;
                     break;
                  }
                  _loc3_.UnlockState = TUnlock.UNLOCKSTATE_Unlocked;
               }
            }
            _loc1_++;
         }
         return _loc7_;
      }
      
      protected function ProcessorUnlockStep() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUnlock = null;
         _loc2_ = this.FUnlocks.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUnlocks.GetUnlockByIndex(_loc1_);
            if(_loc3_.UnlockState == TUnlock.UNLOCKSTATE_Unlocking)
            {
               _loc3_.UnlockState = TUnlock.UNLOCKSTATE_Unlocked;
               if(!(_loc3_.Position != POSITION_Activity && _loc3_.Position != POSITION_Function))
               {
                  this.FUnlock = _loc3_;
                  if(this.FOnUnlockNotification != null)
                  {
                     this.FOnUnlockNotification(this,_loc3_);
                  }
                  this.FIsStartStep = true;
                  break;
               }
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorCheckUnlockResidual() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:TUnlock = null;
         _loc3_ = false;
         _loc2_ = this.FUnlocks.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FUnlocks.GetUnlockByIndex(_loc1_);
            if(_loc4_.UnlockState == TUnlock.UNLOCKSTATE_Unlock)
            {
               _loc3_ = true;
               break;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      protected function ProcessorUnlockResponse(param1:TBounds, param2:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:Sprite = null;
         this.FBounds = param1;
         this.FButton = param2 as SimpleButton;
         switch(this.FUnlock.Position)
         {
            case POSITION_Activity:
               _loc3_ = RESOURCE_ClassName_Activity_Btns[this.FUnlock.Localtion];
               _loc4_ = this.FMC_MountPointActivity;
               this.FMC_SubstrateActivity.visible = true;
               this.FMC_SubstrateFunction.visible = false;
               this.FBounds.X -= this.FButton.width;
               break;
            case POSITION_Function:
               _loc3_ = RESOURCE_ClassName_Function_Btns[this.FUnlock.Localtion];
               _loc4_ = this.FMC_MountPointFunction;
               this.FMC_SubstrateActivity.visible = false;
               this.FMC_SubstrateFunction.visible = true;
         }
         this.FMC_Icon = TUtilityReflection.CreateDisplayObjectInstance(_loc3_) as Sprite;
         addChild(this.FMC_Icon);
         this.FCoordinate = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc4_);
         this.FMC_Icon.x = this.FCoordinate.X;
         this.FMC_Icon.y = this.FCoordinate.Y;
         this.FTF_Desc.text = this.FUnlock.Desc;
         FAffairGenerator.Generate(AFFAIRID_UnlockStart);
         this.SetTweens();
         this.PlayEffects(true);
         this.FUnlockEffects.push(this.FRepeatOper);
      }
      
      protected function SetTweens() : void
      {
         this.FTweenOperStartFadeIn.target = this.FMC_Unlock;
         this.FTweenOperStartFadeIn.params = {"alpha":0};
         this.FTweenOperStartFadeOut.target = this.FMC_Unlock;
         this.FTweenOperStartFadeOut.params = {"alpha":1};
         this.FTweenOperStopFadeIn.target = this.FMC_Unlock;
         this.FTweenOperStopFadeIn.params = {};
         this.FTweenOperStopFadeOut.target = this.FMC_Unlock;
         this.FTweenOperStopFadeOut.params = {};
         this.FTweenOperEndFadeIn.target = this.FMC_Unlock;
         this.FTweenOperEndFadeIn.params = {"alpha":1};
         this.FTweenOperEndFadeOut.target = this.FMC_Unlock;
         this.FTweenOperEndFadeOut.params = {"alpha":0};
         this.FTweenOperMoveIn.target = this.FMC_Icon;
         this.FTweenOperMoveIn.params = {
            "x":this.FMC_Icon.x,
            "y":this.FMC_Icon.y,
            "ease":Cubic.easeIn
         };
         this.FTweenOperMoveOut.target = this.FMC_Icon;
         this.FTweenOperMoveOut.params = {
            "x":this.FBounds.X,
            "y":this.FBounds.Y,
            "ease":Cubic.easeOut
         };
      }
      
      protected function AffairPerform_UnlockStart(param1:TAffair) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = this.AffairPerformUnlockStart();
         if(_loc2_)
         {
            param1.PostProcess = TAffair.POSTPROCESS_Pend;
         }
         else
         {
            param1.PostProcess = TAffair.POSTPROCESS_Remove;
         }
      }
      
      protected function AffairPerformUnlockStart() : Boolean
      {
         var _loc1_:Boolean = false;
         this.FCoordinate.X = this.FMC_Icon.x;
         this.FCoordinate.Y = this.FMC_Icon.y;
         _loc1_ = TUtilityCartisian.BoundsContainsCoordinate(this.FBounds,this.FCoordinate);
         if(_loc1_)
         {
            this.PlayEffects(false);
            this.FButton.alpha = 1;
            removeChild(this.FMC_Icon);
            this.FMC_Icon = null;
            if(this.FOnUnlockedNotification != null)
            {
               this.FOnUnlockedNotification(this,this.FUnlock.Position,this.FUnlock.Localtion);
            }
            this.FIsUnlockResidual = this.ProcessorCheckUnlockResidual();
            if(!this.FIsUnlockResidual)
            {
               this.Dispose();
            }
            this.FIsStartStep = false;
            return false;
         }
         return true;
      }
      
      protected function PlayEffects(param1:Boolean = true) : void
      {
         if(param1)
         {
            if(!Visible)
            {
               BarrierActuate(this);
               this.PlayEffect(param1);
               Visible = param1;
            }
         }
         else if(Visible)
         {
            BarrierDeactuate(this);
            this.PlayEffect(param1);
            Visible = param1;
         }
      }
      
      protected function PlayEffect(param1:Boolean) : void
      {
         if(param1)
         {
            this.FMC_EffectLeft.play();
            this.FMC_EffectRight.play();
         }
         else
         {
            this.FMC_EffectLeft.stop();
            this.FMC_EffectRight.stop();
         }
      }
      
      protected function ProcessorUnlockCheckShortcutsState() : void
      {
         this.ProcessorUnlockState();
         if(this.FOnUpdateShortcutsState != null)
         {
            this.FOnUpdateShortcutsState(this,this.FUnlocks);
         }
         if(this.FIsFirst)
         {
            this.FIsFirst = false;
         }
      }
      
      protected function CheckUnlockState() : Boolean
      {
         var _loc1_:Boolean = false;
         _loc1_ = true;
         if(this.FIsStartStep)
         {
            _loc1_ = false;
         }
         if(this.FChracter.RoleSencePosition != SCENEPOSITION_MAINCITY)
         {
            _loc1_ = false;
         }
         if(SLogicsCore.PlayPlotState != PLOT_MODE_None)
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function get OnUpdateShortcutsState() : Function
      {
         return this.FOnUpdateShortcutsState;
      }
      
      public function set OnUpdateShortcutsState(param1:Function) : void
      {
         this.FOnUpdateShortcutsState = param1;
      }
      
      public function get OnUnlockNotification() : Function
      {
         return this.FOnUnlockNotification;
      }
      
      public function set OnUnlockNotification(param1:Function) : void
      {
         this.FOnUnlockNotification = param1;
      }
      
      public function get OnUnlockedNotification() : Function
      {
         return this.FOnUnlockedNotification;
      }
      
      public function set OnUnlockedNotification(param1:Function) : void
      {
         this.FOnUnlockedNotification = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
      }
      
      override public function Dispose() : void
      {
         this.FTweenOperStartFadeIn = null;
         this.FTweenOperStartFadeOut = null;
         this.FTweenOperStopFadeIn = null;
         this.FTweenOperStopFadeOut = null;
         this.FTweenOperEndFadeIn = null;
         this.FTweenOperEndFadeOut = null;
         this.FTweenOperMoveIn = null;
         this.FTweenOperMoveOut = null;
         this.FRepeatOper.children.length = 0;
         this.FRepeatOper = null;
         removeChild(this.FMC_Unlock);
         this.FMC_Unlock = null;
         this.FTF_Desc = null;
         this.FMC_MountPointActivity = null;
         this.FMC_MountPointFunction = null;
         this.FMC_SubstrateActivity = null;
         this.FMC_SubstrateFunction = null;
         this.FMC_EffectLeft = null;
         this.FMC_EffectRight = null;
      }
      
      public function CheckUnlockShortcutsState() : void
      {
         this.ProcessorUnlockCheckShortcutsState();
         this.FIsCheckUnlockState = true;
      }
      
      public function UnlockResponse(param1:Object, param2:TBounds, param3:Object) : void
      {
         this.ProcessorUnlockResponse(param2,param3);
      }
   }
}


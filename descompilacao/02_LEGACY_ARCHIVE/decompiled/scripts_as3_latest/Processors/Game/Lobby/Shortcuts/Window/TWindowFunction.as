package Processors.Game.Lobby.Shortcuts.Window
{
   import Components.Shortcuts.*;
   import Foundation.Common.*;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Queries.Coordinate.TQueryCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.THeroExp;
   import Logics.SLogicsCore;
   import Logics.Unlocks.TUnlock;
   import Logics.Unlocks.TUnlocks;
   import Processors.Game.Common.Effects.Display.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Rendering.Overlayers.Inventories.TOverWindowFunctionTip;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.TextField;
   import ghostcat.util.easing.TweenUtil;
   
   public class TWindowFunction extends TUIComponent
   {
      
      public static const POSITION_Function:uint = CONST_SHORTCUTS.POSITION_Function;
      
      public static const TYPE_Function_Heros:uint = CONST_SHORTCUTS.TYPE_Function_Heros;
      
      public static const TYPE_Function_Star:uint = CONST_SHORTCUTS.TYPE_Function_Star;
      
      public static const TYPE_Function_TacticalDeployment:uint = CONST_SHORTCUTS.TYPE_Function_TacticalDeployment;
      
      public static const TYPE_Function_Backpack:uint = CONST_SHORTCUTS.TYPE_Function_Backpack;
      
      public static const TYPE_Function_Treasure:uint = CONST_SHORTCUTS.TYPE_Function_Treasure;
      
      public static const TYPE_Function_SummonPet:uint = CONST_SHORTCUTS.TYPE_Function_SummonPet;
      
      public static const TYPE_Function_Strengthen:uint = CONST_SHORTCUTS.TYPE_Function_Strengthen;
      
      public static const TYPE_Function_Mail:uint = CONST_SHORTCUTS.TYPE_Function_Mail;
      
      public static const TYPE_Function_TongLing:uint = CONST_SHORTCUTS.TYPE_Function_TongLing;
      
      public static const TYPE_Function_OrganiZation:uint = CONST_SHORTCUTS.TYPE_Function_OrganiZation;
      
      public static const TYPE_Function_InheritPractice:uint = CONST_SHORTCUTS.TYPE_Function_InheritPractice;
      
      public static const TYPE_Function_Return:uint = CONST_SHORTCUTS.TYPE_Function_Return;
      
      public static const FUNCTIONS_TYPE:Vector.<uint> = CONST_SHORTCUTS.FUNCTIONS_TYPE;
      
      public static const RESOURCE_ClassName_Function_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_Function_Btns;
      
      protected static const COORDINATE_Shortcut_X:int = 1136;
      
      protected static const COORDINATE_Shortcut_Y:int = 11;
      
      public static const COORDINATE_FunctionBtn:Vector.<int> = Vector.<int>([0,-20]);
      
      protected var FCharacter:TCharacter;
      
      protected var FBackground:Sprite;
      
      protected var FMC_ProgressBarExp:Sprite;
      
      protected var FMC_ProgressBarExpFather:MovieClip;
      
      protected var FTF_Experience:TextField;
      
      protected var FHomeland:SimpleButton;
      
      protected var FRose:MovieClip;
      
      protected var FUIShortcut:TUIShortcut;
      
      protected var FEffectsBaseGlow:Vector.<TEffectBaseGlow>;
      
      protected var FGlowFilter:GlowFilter;
      
      protected var FUnlockStates:Vector.<Boolean>;
      
      protected var FWidth:int;
      
      protected var FHeight:int;
      
      protected var FIsInitialization:Boolean;
      
      protected var FOverWindowFunctionTip:TOverWindowFunctionTip;
      
      protected var FOnMainFunction:Function;
      
      protected var FOnUnlockFunctionResponse:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      public function TWindowFunction(param1:TUIComponent)
      {
         super(param1);
         this.FCharacter = SLogicsCore.Character;
         this.FUIShortcut = new TUIShortcut(this);
         this.FUIShortcut.X = 729 - 114;
         this.FUIShortcut.Y = COORDINATE_Shortcut_Y;
         this.FUIShortcut.Capacity = FUNCTIONS_TYPE.length;
         this.FUIShortcut.OnBtnMove = this.BtnOnMove;
         this.FUIShortcut.OnBtnOut = this.BtnOnOut;
         this.FUIShortcut.OnBtnDown = this.BtnOnDown;
         this.FUIShortcut.OnBtnUp = this.BtnOnUp;
         this.FEffectsBaseGlow = new Vector.<TEffectBaseGlow>();
         this.FGlowFilter = new GlowFilter(8453888,0.6,3,3,8,10,false,false);
         this.FUnlockStates = new Vector.<Boolean>(FUNCTIONS_TYPE.length);
         this.Visible = false;
         this.mouseEnabled = false;
         this.FWidth = 0;
         this.FOverWindowFunctionTip = new TOverWindowFunctionTip(param1);
         this.FOverWindowFunctionTip.visible = false;
         this.FIsInitialization = false;
      }
      
      protected function Resources_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:Sprite = null;
         var _loc5_:SimpleButton = null;
         var _loc6_:THint = null;
         this.FBackground = TUtilityReflection.CreateDisplayObjectInstance(CONST_SHORTCUTS.RESOURCE_ClassName_Function_MC_Background) as Sprite;
         this.FBackground.mouseEnabled = false;
         this.addChild(this.FBackground);
         this.FHomeland = this.FBackground["BTN_Homeland"];
         if(this.FHomeland)
         {
            this.FHomeland.alpha = 0;
            this.FHomeland.visible = false;
            this.FHomeland.addEventListener(MouseEvent.CLICK,this.onHomelandClick);
         }
         this.FRose = this.FBackground["MC_Rose"];
         if(this.FRose)
         {
            this.FRose.alpha = 0;
            this.FRose.visible = false;
            this.FRose.mouseEnabled = this.FRose.mouseChildren = false;
         }
         THomelandModel.UpdateShortcuts = this.UpdateShortcuts;
         _loc4_ = this.FBackground[CONST_SHORTCUTS.RESOURCE_Link_MC_ProgressBarExpMountPoint];
         this.FMC_ProgressBarExpFather = TUtilityReflection.CreateDisplayObjectInstance(CONST_SHORTCUTS.RESOURCE_Link_MC_ProgressBarExp) as MovieClip;
         this.FMC_ProgressBarExpFather.gotoAndStop(1);
         this.FMC_ProgressBarExp = this.FMC_ProgressBarExpFather["MC_Exp"];
         this.FMC_ProgressBarExp.mouseEnabled = false;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            this.FMC_ProgressBarExpFather["MC_" + _loc1_].visible = false;
            _loc1_++;
         }
         _loc4_.addChild(this.FMC_ProgressBarExpFather);
         this.FTF_Experience = this.FBackground[CONST_SHORTCUTS.RESOURCE_Link_TF_Exp];
         this.FTF_Experience.mouseEnabled = false;
         this.FUIShortcut.Bmp_Left = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Function_Bmp_Left);
         this.FUIShortcut.BmpData_Middle = TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Function_Bmp_Middle);
         this.FUIShortcut.Bmp_Right = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Function_Bmp_Right);
         _loc2_ = int(FUNCTIONS_TYPE.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = RESOURCE_ClassName_Function_Btns[_loc1_];
            _loc5_ = TUtilityReflection.CreateSimpleButtonByDisplayObject(_loc3_) as SimpleButton;
            this.FUIShortcut.SetButtonByIndex(_loc5_,_loc1_);
            _loc6_ = new THint();
            _loc6_.Caption = STRING_SHORTCUTS.CAPTIONS_HintFunctionCaption[_loc1_];
            this.FUIShortcut.SetHintByIndex(_loc6_,_loc1_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUnlockStates[_loc1_] = false;
            _loc1_++;
         }
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverWindowFunctionTip);
      }
      
      protected function Resources_UILocations() : void
      {
         this.FUIShortcut.CoordinateBtn = COORDINATE_FunctionBtn;
         this.FUIShortcut.Perform_UIDispatch();
         this.InitializationFunctions();
      }
      
      protected function InitializationFunctions() : void
      {
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_Heros);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_Star);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_TacticalDeployment);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_Backpack);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_Treasure);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_SummonPet);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_Strengthen);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_Mail);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_TongLing);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_OrganiZation);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_InheritPractice);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_Return);
         this.FUIShortcut.SetFunctionByIndex(this.MainFunctionOnClick,TYPE_Function_InheritPractice);
      }
      
      protected function UpdateFunctionShortcuts(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc5_:SimpleButton = null;
         var _loc6_:TEffectBaseGlow = null;
         if(!this.FUIShortcut.IsInitialization)
         {
            return;
         }
         _loc3_ = int(this.FUIShortcut.Capacity);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FUIShortcut.GetBmp_Middle(_loc2_);
            _loc5_ = this.FUIShortcut.GetButtonByIndex(_loc2_);
            _loc4_.visible = _loc5_.visible;
            _loc2_++;
         }
         this.FUIShortcut.UpdateComponentsLocation();
         this.FUIShortcut.X = 729 - 114 - this.FUIShortcut.Bounds.Width;
      }
      
      protected function UpdateEffectsGlow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TEffectBaseGlow = null;
         _loc2_ = int(this.FEffectsBaseGlow.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FEffectsBaseGlow[_loc1_];
            _loc3_.Run();
            _loc1_++;
         }
      }
      
      protected function UpdateCharacterInfo() : void
      {
         var _loc1_:THero = null;
         var _loc2_:THeroExp = null;
         var _loc3_:UInt64 = null;
         var _loc4_:UInt64 = null;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:Vector.<Object> = null;
         var _loc8_:int = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:UInt64 = null;
         var _loc11_:String = null;
         if(this.FIsInitialization)
         {
            if(Boolean(this.FHomeland) && this.FHomeland.alpha == 0)
            {
               this.FHomeland.alpha = 1;
               THomelandModel.PerformPacket_CS_InfoReq();
            }
            _loc1_ = this.FCharacter.MainHero;
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroExp,_loc1_.Level) as THeroExp;
            _loc3_ = _loc1_.Experience;
            _loc4_ = _loc2_.NeedExp;
            _loc6_ = "";
            if(_loc1_.Level >= 3050)
            {
               _loc4_ = this.FCharacter.ConfigAllExp;
               if(this.FMC_ProgressBarExpFather.currentFrame == 1)
               {
                  _loc11_ = "";
                  this.FMC_ProgressBarExpFather.gotoAndStop(2);
                  this.FMC_ProgressBarExp = this.FMC_ProgressBarExpFather["MC_Exp"];
                  _loc7_ = this.FCharacter.ConfigArrInformation;
                  _loc8_ = 0;
                  while(_loc8_ < 3)
                  {
                     _loc9_ = this.FMC_ProgressBarExpFather["MC_" + _loc8_];
                     _loc9_.visible = true;
                     _loc11_ = String(_loc7_[_loc8_][0]);
                     _loc10_ = UInt64.ParseUInt64(_loc11_);
                     _loc9_.x = _loc10_.ToNumber() / _loc4_.ToNumber() * this.FMC_ProgressBarExp.width;
                     _loc9_.addEventListener(MouseEvent.MOUSE_OVER,this.OverClick);
                     _loc9_.addEventListener(MouseEvent.MOUSE_OUT,this.OutClick);
                     _loc9_.addEventListener(MouseEvent.MOUSE_MOVE,this.MoveClick);
                     _loc8_++;
                  }
               }
               _loc6_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_Experience,_loc3_.ToString(),_loc4_.ToString());
            }
            else if(_loc1_.Level == 150 || _loc1_.Level == 1050)
            {
               _loc6_ = STRING_SHORTCUTS.STRING_NORMAL_Nimei;
               if(this.FMC_ProgressBarExp.visible)
               {
                  this.FMC_ProgressBarExp.visible = false;
               }
            }
            else
            {
               _loc6_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_Experience,_loc3_.ToString(),_loc4_.ToString());
               if(!this.FMC_ProgressBarExp.visible)
               {
                  this.FMC_ProgressBarExp.visible = true;
               }
            }
            this.FTF_Experience.text = _loc6_;
            _loc5_ = _loc3_.ToNumber() / _loc4_.ToNumber();
            if(_loc5_ > 1)
            {
               _loc5_ = 1;
            }
            this.FMC_ProgressBarExp.scaleX = _loc5_;
         }
      }
      
      protected function Reset() : void
      {
         this.FTF_Experience.text = "EXP: 0/0";
      }
      
      protected function UpdateBounds() : void
      {
         if(!this.FIsInitialization)
         {
            return;
         }
         if(this.FUIShortcut.Bounds.Width > 0)
         {
            this.FWidth = this.FBackground.width;
            this.FHeight = this.FBackground.height;
         }
         else
         {
            this.FWidth = 0;
            this.FHeight = 0;
         }
      }
      
      protected function ProcessorShortcutShowEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         if(!this.FUIShortcut || !this.FUIShortcut.IsEffectLength)
         {
            return;
         }
         _loc3_ = this.FUIShortcut.GetIsEffectByIndex(param1);
         if(_loc3_ != param2)
         {
            this.FUIShortcut.SetIsEffectByIndex(param2,param1);
         }
         if(param2)
         {
            this.OpenButtonEffect(param1);
         }
         else
         {
            this.TerminationButtonEffect(param1);
         }
      }
      
      protected function OpenButtonEffect(param1:int) : void
      {
         var _loc2_:SimpleButton = null;
         var _loc3_:TEffectBaseGlow = null;
         if(!this.FUIShortcut.IsInitialization)
         {
            return;
         }
         _loc2_ = this.FUIShortcut.GetButtonByIndex(param1);
         if(_loc2_.filters != null && _loc2_.filters.length == 0)
         {
            _loc3_ = new TEffectBaseGlow();
            _loc3_.SetParameters(_loc2_,15911245,1);
            _loc3_.Run();
            this.FEffectsBaseGlow.push(_loc3_);
         }
      }
      
      protected function TerminationButtonEffect(param1:int) : void
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:SimpleButton = null;
         var _loc5_:TEffectBaseGlow = null;
         if(!this.FUIShortcut.IsInitialization)
         {
            return;
         }
         _loc4_ = this.FUIShortcut.GetButtonByIndex(param1);
         _loc3_ = int(this.FEffectsBaseGlow.length);
         _loc2_ = int(_loc3_ - 1);
         while(_loc2_ >= 0)
         {
            _loc5_ = this.FEffectsBaseGlow[_loc2_];
            if(_loc5_ == null)
            {
               break;
            }
            if(_loc4_ == _loc5_.Source)
            {
               _loc5_.Stop();
               this.FEffectsBaseGlow.splice(_loc2_,1);
               _loc5_.Dispose();
               _loc5_ = null;
               break;
            }
            _loc2_--;
         }
      }
      
      protected function MainFunctionOnClick(param1:Object, param2:int) : void
      {
         var _loc3_:SimpleButton = (param1 as MouseEvent).currentTarget as SimpleButton;
         if(this.FOnMainFunction != null)
         {
            this.FOnMainFunction(this,param2);
         }
      }
      
      protected function BtnOnMove(param1:Object, param2:int) : void
      {
         var _loc3_:SimpleButton = null;
         var _loc4_:THint = null;
         _loc3_ = this.FUIShortcut.GetButtonByIndex(param2);
         if(_loc3_.filters.length == 0)
         {
            _loc3_.filters = [this.FGlowFilter];
         }
         if(this.FHintOnOver != null)
         {
            _loc4_ = this.FUIShortcut.GetHintByIndex(param2);
            this.FHintOnOver(param1,_loc4_);
         }
      }
      
      protected function BtnOnOut(param1:Object, param2:int) : void
      {
         var _loc3_:SimpleButton = null;
         _loc3_ = this.FUIShortcut.GetButtonByIndex(param2);
         _loc3_.filters = [];
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(param1);
         }
      }
      
      protected function BtnOnDown(param1:Object, param2:int) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:SimpleButton = null;
         _loc4_ = param1 as SimpleButton;
         if(_loc4_.filters.length > 0)
         {
            _loc4_.filters = [];
         }
         _loc3_ = this.FUIShortcut.GetIsEffectByIndex(param2);
         if(_loc3_)
         {
            this.ProcessorShortcutShowEffect(param2,false);
         }
      }
      
      protected function BtnOnUp(param1:Object, param2:int) : void
      {
         var _loc3_:SimpleButton = param1 as SimpleButton;
         if(_loc3_.filters.length == 0)
         {
            _loc3_.filters = [this.FGlowFilter];
         }
      }
      
      public function get ShortcutWidth() : int
      {
         this.UpdateBounds();
         return this.FWidth;
      }
      
      public function get ShortcutHeight() : int
      {
         this.UpdateBounds();
         return this.FHeight;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get OnMainFunction() : Function
      {
         return this.FOnMainFunction;
      }
      
      public function set OnMainFunction(param1:Function) : void
      {
         this.FOnMainFunction = param1;
      }
      
      public function get OnUnlockFunctionResponse() : Function
      {
         return this.FOnUnlockFunctionResponse;
      }
      
      public function set OnUnlockFunctionResponse(param1:Function) : void
      {
         this.FOnUnlockFunctionResponse = param1;
      }
      
      public function Update() : void
      {
         this.UpdateEffectsGlow();
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
         this.Reset();
         this.FIsInitialization = true;
      }
      
      public function UpdateShortcutsState(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:TUnlock = null;
         var _loc6_:SimpleButton = null;
         var _loc7_:TUnlocks = null;
         _loc7_ = param1 as TUnlocks;
         _loc3_ = _loc7_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc7_.GetUnlockByIndex(_loc2_);
            if(_loc5_.Position == POSITION_Function)
            {
               _loc4_ = false;
               if(_loc5_.State == TUnlock.UNLOCKSTATE_Unlocked)
               {
                  _loc4_ = true;
                  this.FUnlockStates[_loc5_.Localtion] = _loc4_;
                  _loc6_ = this.FUIShortcut.GetButtonByIndex(_loc5_.Localtion);
                  _loc6_.visible = _loc4_;
                  if(_loc5_.Identifier == CONST_CONFIGVALUE.UNLOCK_Return)
                  {
                     _loc6_.visible = false;
                  }
               }
            }
            _loc2_++;
         }
         this.UpdateFunctionShortcuts();
      }
      
      public function UnlockNotification(param1:TUnlock) : void
      {
         var _loc2_:SimpleButton = null;
         var _loc3_:TCoordinate = null;
         var _loc4_:TBounds = null;
         _loc2_ = this.FUIShortcut.GetButtonByIndex(param1.Localtion);
         _loc2_.alpha = 0;
         _loc2_.visible = true;
         this.FUnlockStates[param1.Localtion] = true;
         this.UpdateFunctionShortcuts(true);
         if(this.FOnUnlockFunctionResponse != null)
         {
            _loc3_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc2_);
            _loc4_ = new TBounds();
            _loc4_.Assign(_loc3_);
            _loc4_.Width = _loc2_.width;
            _loc4_.Height = _loc2_.height;
            this.FOnUnlockFunctionResponse(this,_loc4_,_loc2_);
         }
         this.ProcessorShortcutShowEffect(param1.Localtion,true);
      }
      
      public function ShortcutsSetup(param1:TLobbyShortcutFunctionModes) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:SimpleButton = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         if(!this.FIsInitialization)
         {
            return;
         }
         if(!this.FUIShortcut.IsInitialization)
         {
            return;
         }
         _loc2_ = int(this.FUIShortcut.Capacity);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.GetShortcutModeByIndex(_loc3_);
            _loc5_ = this.FUIShortcut.GetButtonByIndex(_loc3_);
            switch(_loc4_)
            {
               case TLobbyShortcutMode.SHORTCUTMODE_Show:
                  _loc6_ = true;
                  break;
               case TLobbyShortcutMode.SHORTCUTMODE_Hidden:
                  _loc6_ = false;
            }
            _loc7_ = this.FUnlockStates[_loc3_];
            if(!_loc7_)
            {
               _loc6_ = _loc7_;
            }
            _loc5_.visible = _loc6_;
            _loc3_++;
         }
         this.UpdateFunctionShortcuts();
      }
      
      public function UserUpdateCharBaseInfo() : void
      {
         this.UpdateCharacterInfo();
      }
      
      public function ShowEffectNotification(param1:uint, param2:Boolean) : void
      {
         this.ProcessorShortcutShowEffect(param1,param2);
      }
      
      public function QueryShortcutCoordinate(param1:Object, param2:uint, param3:TQueryCoordinate) : void
      {
         var _loc4_:SimpleButton = null;
         var _loc5_:TCoordinate = null;
         _loc4_ = this.FUIShortcut.GetButtonByIndex(param2);
         _loc5_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc4_);
         _loc5_.X += _loc4_.width / 2 - 12;
         _loc5_.Y += _loc4_.height / 2 - 6;
         param3.Value.Assign(_loc5_);
      }
      
      protected function OverClick(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:String = _loc2_.charAt(_loc2_.length - 1);
         if(this.FOverWindowFunctionTip != null)
         {
            this.FOverWindowFunctionTip.Context = _loc3_;
            this.FOverWindowFunctionTip.Render(FUICore.MouseCoordinate);
            this.FOverWindowFunctionTip.Show();
         }
      }
      
      protected function OutClick(param1:MouseEvent) : void
      {
         if(this.FOverWindowFunctionTip != null)
         {
            this.FOverWindowFunctionTip.Hide();
         }
      }
      
      protected function MoveClick(param1:MouseEvent) : void
      {
         if(this.FOverWindowFunctionTip != null)
         {
            this.FOverWindowFunctionTip.Render(FUICore.MouseCoordinate);
         }
      }
      
      protected function onHomelandClick(param1:MouseEvent) : void
      {
         if(this.FOnMainFunction != null)
         {
            this.FOnMainFunction(this,99);
         }
      }
      
      protected function UpdateShortcuts() : void
      {
         var up:Function = null;
         var down:Function = null;
         up = function():void
         {
            if(FRose.visible == false)
            {
               return;
            }
            TweenUtil.removeTween(FRose);
            FRose.alpha = 1;
            FRose.x = 635;
            FRose.y = -40;
            TweenUtil.to(FRose,1000,{
               "y":-60,
               "alpha":0.8,
               "onComplete":down
            });
         };
         down = function():void
         {
            if(FRose.visible == false)
            {
               return;
            }
            TweenUtil.removeTween(FRose);
            TweenUtil.to(FRose,1000,{
               "y":-40,
               "alpha":1,
               "onComplete":up
            });
         };
         if(this.FHomeland)
         {
            this.FHomeland.visible = THomelandModel.selfHome.status == 1;
            if(this.FHomeland.visible)
            {
               this.FRose.visible = THomelandModel.getPickRose() > 0;
               if(this.FRose.visible)
               {
                  up();
               }
            }
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
      }
      
      override public function set Y(param1:int) : void
      {
         super.Y = param1;
      }
   }
}


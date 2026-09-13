package Processors.Game.Lobby.Shortcuts.Window
{
   import Components.Shortcuts.*;
   import Foundation.Common.*;
   import Foundation.Fonts.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.ActivityMode.*;
   import Logics.Agent.SParametersCore;
   import Logics.TimeCoolDown.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import Utilities.Timing.*;
   import flash.display.*;
   import ghostcat.operation.*;
   import ghostcat.util.easing.*;
   
   public class TWindowActiveListSecondary extends TUIComponent
   {
      
      public static const TYPE_ActiveListSecondary_FirstDayGiftBag:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_FirstDayGiftBag;
      
      public static const TYPE_ActiveListSecondary_OnLineGiftBag:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_OnLineGiftBag;
      
      public static const TYPE_ActiveListSecondary_GoldGiftBag:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_GoldGiftBag;
      
      public static const TYPE_ActiveListSecondary_7DayGiftBag:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_7DayGiftBag;
      
      public static const TYPE_ActiveListSecondary_HFReward:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_HFReward;
      
      public static const TYPE_ActiveListSecondary_LevelGift:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_LevelGift;
      
      public static const TYPE_ActiveListSecondary_CollectGame:uint = CONST_SHORTCUTS.TYPE_ActiveListSecondary_CollectGame;
      
      public static const ACTIVELIST_SECONDARY_TYPE:Vector.<uint> = CONST_SHORTCUTS.ACTIVELIST_SECONDARY_TYPE;
      
      public static const RESOURCE_ClassName_ActiveListSecondary_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_ActiveListSecondary_Btns;
      
      public static const TYPE_ActiveList_ReceivePacks:uint = CONST_SHORTCUTS.TYPE_ActiveList_ReceivePacks;
      
      protected static const COORDINATE_ActivityBtn:Vector.<int> = Vector.<int>([1,7]);
      
      protected static const COLOR_ContextDefault:uint = 4294967295;
      
      protected var FRepeatOper:RepeatOper;
      
      protected var FTweenOperIn:TweenOper;
      
      protected var FTweenOperOut:TweenOper;
      
      protected var FActivityModes:TActivityModes;
      
      protected var FTimeCoolDowns:TTimeCoolDowns;
      
      protected var FPainterTime:TPainterText;
      
      protected var FBoundsTime:TBounds;
      
      protected var FBmp_Pointer:Bitmap;
      
      protected var FUIShortcut:TUIShortcut;
      
      protected var FUnlockStates:Vector.<Boolean>;
      
      protected var FIsInitialization:Boolean;
      
      protected var FOnActiveListSecondary:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      public function TWindowActiveListSecondary(param1:TUIComponent)
      {
         super(param1);
         this.FActivityModes = SLogicsCore.ActivityModes;
         this.FTimeCoolDowns = SLogicsCore.Character.TimeCoolDowns;
         this.FUIShortcut = new TUIShortcut(this);
         this.FUIShortcut.Capacity = ACTIVELIST_SECONDARY_TYPE.length;
         this.FUIShortcut.OnBtnMove = this.BtnOnMove;
         this.FUIShortcut.OnBtnOut = this.BtnOnOut;
         this.FPainterTime = this.ConstructPainterTextEffect();
         this.FPainterTime.Visible = false;
         this.FBoundsTime = new TBounds();
         this.ConstructTweens();
         this.FUnlockStates = new Vector.<Boolean>(ACTIVELIST_SECONDARY_TYPE.length);
      }
      
      protected function ConstructPainterTextEffect(param1:uint = 4294967295) : TPainterTextEffect
      {
         var _loc2_:TPainterTextEffect = null;
         _loc2_ = new TPainterTextEffect(this);
         SFontCore.FontSelect(_loc2_.Font,CONST_OVERLAYER.TEXT_ANTIALIAS_FontSetName,CONST_OVERLAYER.TEXT_ANTIALIAS_FontSetSize,CONST_OVERLAYER.TEXT_ANTIALIAS_FontSetBold);
         _loc2_.Font.Color = param1;
         _loc2_.FontEffect.AntiAliased = true;
         _loc2_.FontEffect.Outlined = true;
         _loc2_.FontEffect.Shadowed = true;
         return _loc2_;
      }
      
      protected function ConstructTweens() : void
      {
         this.FRepeatOper = new RepeatOper();
         this.FTweenOperIn = new TweenOper();
         this.FTweenOperOut = new TweenOper();
         this.FTweenOperIn.duration = 10;
         this.FTweenOperIn.target = this;
         this.FTweenOperOut.duration = 150;
         this.FTweenOperOut.target = this;
         this.FRepeatOper.loop = 1;
         this.FRepeatOper.children = [this.FTweenOperIn,this.FTweenOperOut];
      }
      
      protected function Resources_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:SimpleButton = null;
         var _loc5_:THint = null;
         var _loc6_:TAnimationSequence = null;
         this.FUIShortcut.Bmp_Left = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_ActivitySecondary_Bmp_Left);
         this.FUIShortcut.BmpData_Middle = TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_ActivitySecondary_Bmp_Middle);
         this.FUIShortcut.Bmp_Right = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_ActivitySecondary_Bmp_Right);
         this.FBoundsTime.Width = this.FUIShortcut.BmpData_Middle.width;
         this.FBoundsTime.Height = this.FUIShortcut.BmpData_Middle.height / 2;
         _loc6_ = SResourcesCore.TexturesLobby.GetAnimationSequenceByIdentifiers(CONST_LOBBY.RESOURCESID_Textures_ShortcutEffect,0);
         this.FUIShortcut.Effects = _loc6_;
         this.FBmp_Pointer = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_ActivitySecondary_Bmp_Pointer);
         _loc2_ = int(ACTIVELIST_SECONDARY_TYPE.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = RESOURCE_ClassName_ActiveListSecondary_Btns[_loc1_];
            _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject(_loc3_) as SimpleButton;
            if(_loc4_ == null)
            {
               _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject("Shortcuts_Activity_SubmitBug") as SimpleButton;
            }
            this.FUIShortcut.SetButtonByIndex(_loc4_,_loc1_);
            _loc5_ = new THint();
            this.FUIShortcut.SetHintByIndex(_loc5_,_loc1_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUnlockStates[_loc1_] = false;
            _loc1_++;
         }
      }
      
      protected function Resources_UILocations() : void
      {
         this.FUIShortcut.CoordinateBtn = COORDINATE_ActivityBtn;
         this.FUIShortcut.Perform_UIDispatch();
         addChild(this.FBmp_Pointer);
         this.InitializationActivitys();
      }
      
      protected function InitializationActivitys() : void
      {
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListSecondaryOnClick,TYPE_ActiveListSecondary_FirstDayGiftBag);
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListSecondaryOnClick,TYPE_ActiveListSecondary_OnLineGiftBag);
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListSecondaryOnClick,TYPE_ActiveListSecondary_GoldGiftBag);
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListSecondaryOnClick,TYPE_ActiveListSecondary_7DayGiftBag);
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListSecondaryOnClick,TYPE_ActiveListSecondary_HFReward);
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListSecondaryOnClick,TYPE_ActiveListSecondary_LevelGift);
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListSecondaryOnClick,TYPE_ActiveListSecondary_CollectGame);
      }
      
      protected function ProcessorOpenStatusNotification() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:SimpleButton = null;
         if(!this.FIsInitialization)
         {
            return;
         }
         if(!this.FUIShortcut.IsInitialization)
         {
            return;
         }
         _loc2_ = 4;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivityModes.GetActivitySecondIconIsOn(TActivityModes.ICONTYPE_GiftBag,_loc1_ + 1);
            _loc4_ = this.FUIShortcut.GetButtonByIndex(_loc1_);
            if(_loc4_.visible != _loc3_)
            {
               _loc4_.visible = _loc3_;
            }
            _loc1_++;
         }
         if(SParametersCore.IsCombinServer)
         {
            _loc3_ = this.FActivityModes.GetActivitySecondIconIsOn(TActivityModes.ICONTYPE_GiftBag,TYPE_ActiveListSecondary_HFReward + 1);
            _loc4_ = this.FUIShortcut.GetButtonByIndex(TYPE_ActiveListSecondary_HFReward);
            if(_loc4_.visible != _loc3_)
            {
               _loc4_.visible = _loc3_;
            }
         }
         else
         {
            _loc3_ = false;
            _loc4_ = this.FUIShortcut.GetButtonByIndex(TYPE_ActiveListSecondary_HFReward);
            if(_loc4_.visible != _loc3_)
            {
               _loc4_.visible = _loc3_;
            }
         }
         if(this.FUIShortcut.Capacity > 5)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FUIShortcut.Capacity - 5)
            {
               _loc3_ = this.FActivityModes.GetActivitySecondIconIsOn(TActivityModes.ICONTYPE_GiftBag,SParametersCore.IsCombinServer ? uint(_loc1_ + 6) : uint(_loc1_ + 5));
               _loc4_ = this.FUIShortcut.GetButtonByIndex(_loc1_ + 5);
               if(_loc4_.visible != _loc3_)
               {
                  _loc4_.visible = _loc3_;
               }
               _loc1_++;
            }
         }
         this.UpdateActiveListShortcuts();
      }
      
      protected function UpdateActiveListShortcuts() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Bitmap = null;
         var _loc4_:SimpleButton = null;
         var _loc5_:Boolean = false;
         _loc2_ = int(this.FUIShortcut.Capacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIShortcut.GetBmp_Middle(_loc1_);
            _loc4_ = this.FUIShortcut.GetButtonByIndex(_loc1_);
            _loc5_ = _loc4_.visible;
            _loc3_.visible = _loc5_;
            if(!_loc5_)
            {
               this.FUIShortcut.SetIsEffectByIndex(_loc5_,_loc1_);
            }
            _loc1_++;
         }
         this.FUIShortcut.UpdateComponentsLocation();
      }
      
      protected function ComponentsAlign() : void
      {
         if(!this.Visible)
         {
            return;
         }
         this.FBmp_Pointer.x = (this.ShortcutWidth - this.FBmp_Pointer.width) / 2;
         this.FBmp_Pointer.y = this.FUIShortcut.Y - this.FBmp_Pointer.height + 2;
      }
      
      protected function LogicsPerform_TimeCoolDown() : void
      {
         var _loc1_:SimpleButton = null;
         var _loc2_:TTimeCoolDown = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = this.FTimeCoolDowns.GetDigestByIdentifier(CONST_COMMON.TIME_COOLDOWN_Activity_OnlineGiftBag);
         if(_loc2_ != null)
         {
            if(_loc2_.TimingTime > 0)
            {
               _loc3_ = int(_loc2_.TimingTime);
               _loc4_ = TUtilityTiming.FormatDHMSBySeconds(_loc3_);
               this.FPainterTime.Text = _loc4_;
               _loc1_ = this.FUIShortcut.GetButtonByIndex(TYPE_ActiveListSecondary_OnLineGiftBag);
               this.FBoundsTime.X = _loc1_.x;
               this.FBoundsTime.Y = _loc1_.y;
               this.FPainterTime.RenderBounds(this.FBoundsTime,TAlignment.HORIZONTAL_Center,TAlignment.VERTICAL_Center);
               if(!this.FPainterTime.Visible)
               {
                  this.FPainterTime.Visible = true;
               }
            }
            else if(this.FPainterTime.Visible)
            {
               this.FPainterTime.Visible = false;
            }
         }
      }
      
      protected function UpdateShortcutEffect() : void
      {
         if(this.FUIShortcut.IsInitialization)
         {
            this.FUIShortcut.UpdataEffect();
         }
      }
      
      protected function ProcessorShortcutShowEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:SimpleButton = null;
         var _loc4_:Boolean = false;
         _loc3_ = this.FUIShortcut.GetButtonByIndex(param1);
         if(!_loc3_.visible)
         {
            return;
         }
         _loc4_ = this.FUIShortcut.GetIsEffectByIndex(param1);
         if(_loc4_ != param2)
         {
            this.FUIShortcut.SetIsEffectByIndex(param2,param1);
         }
      }
      
      protected function ActiveListSecondaryOnClick(param1:Object, param2:int) : void
      {
         if(this.FOnActiveListSecondary != null)
         {
            this.FOnActiveListSecondary(this,param2);
         }
      }
      
      protected function BtnOnMove(param1:Object, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:SimpleButton = null;
         var _loc6_:THint = null;
         var _loc7_:TActivityAtoms = null;
         var _loc8_:TActivityAtom = null;
         var _loc9_:String = null;
         _loc9_ = "";
         switch(param2)
         {
            case TYPE_ActiveListSecondary_OnLineGiftBag:
               _loc7_ = this.FActivityModes.GetActivityAtomsBySecondType(TActivityModes.ICONTYPE_GiftBag,TActivityModes.ICONTYPE_Second_Online);
               break;
            case TYPE_ActiveListSecondary_GoldGiftBag:
               _loc7_ = this.FActivityModes.GetActivityAtomsBySecondType(TActivityModes.ICONTYPE_GiftBag,TActivityModes.ICONTYPE_Second_Gold);
         }
         if(_loc7_ != null)
         {
            _loc4_ = _loc7_.Count;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc8_ = _loc7_.GetActivityAtomByIndex(_loc3_);
               if(_loc8_.ActiveStatus >= 0)
               {
                  _loc9_ = _loc8_.Tips[0];
                  break;
               }
               _loc3_++;
            }
            if(TUtilityString.Empty(_loc9_))
            {
               return;
            }
            if(this.FHintOnOver != null)
            {
               _loc6_ = this.FUIShortcut.GetHintByIndex(param2);
               _loc6_.Caption = _loc9_;
               this.FHintOnOver(param1,_loc6_);
            }
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
      
      protected function PerformTweenOperOnStart(param1:TweenEvent) : void
      {
         if(!this.Visible)
         {
            this.Visible = true;
         }
      }
      
      protected function PerformTweenOperOnComplete(param1:TweenEvent) : void
      {
         if(this.Visible)
         {
            this.Visible = false;
         }
      }
      
      public function get ShortcutWidth() : int
      {
         return this.FUIShortcut.Bounds.Width;
      }
      
      public function get OnActiveListSecondary() : Function
      {
         return this.FOnActiveListSecondary;
      }
      
      public function set OnActiveListSecondary(param1:Function) : void
      {
         this.FOnActiveListSecondary = param1;
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
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
         this.FIsInitialization = true;
      }
      
      public function Show() : void
      {
         this.FTweenOperIn.params = {
            "alpha":this.alpha,
            "ease":Cubic.easeIn,
            "onStartHandler":this.PerformTweenOperOnStart
         };
         this.FTweenOperOut.params = {
            "alpha":1,
            "ease":Cubic.easeOut,
            "onCompleteHandler":this.PerformTweenOperOnStart
         };
         this.FRepeatOper.execute();
      }
      
      public function Hide() : void
      {
         this.FTweenOperIn.params = {
            "alpha":this.alpha,
            "ease":Cubic.easeOut,
            "onStartHandler":this.PerformTweenOperOnStart
         };
         this.FTweenOperOut.params = {
            "alpha":0,
            "ease":Cubic.easeIn,
            "onCompleteHandler":this.PerformTweenOperOnComplete
         };
         this.FRepeatOper.execute();
      }
      
      public function Update() : void
      {
         this.ComponentsAlign();
         this.LogicsPerform_TimeCoolDown();
         this.UpdateShortcutEffect();
      }
      
      public function OpenStatusNotification() : void
      {
         this.ProcessorOpenStatusNotification();
      }
      
      public function ShowEffectNotification(param1:uint, param2:Boolean) : void
      {
         this.ProcessorShortcutShowEffect(param1,param2);
      }
   }
}


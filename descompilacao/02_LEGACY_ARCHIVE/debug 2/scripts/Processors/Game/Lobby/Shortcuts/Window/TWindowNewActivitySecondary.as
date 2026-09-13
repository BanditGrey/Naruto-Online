package Processors.Game.Lobby.Shortcuts.Window
{
   import Components.Shortcuts.TUIShortcut;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.NewActivity.TNewActivityModes;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutActivityModes;
   import Resources.Constants.CONST_LOBBY;
   import Resources.Constants.CONST_SHORTCUTS;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import ghostcat.operation.RepeatOper;
   import ghostcat.operation.TweenOper;
   import ghostcat.util.easing.TweenEvent;
   
   public class TWindowNewActivitySecondary extends TUIComponent
   {
      
      public static const NEW_ACTIVELIST_SECONDARY_TYPE:Vector.<uint> = CONST_SHORTCUTS.NEW_ACTIVELIST_SECONDARY_TYPE;
      
      public static const RESOURCE_ClassName_NewActiveList_Secondary_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_NewActiveList_Secondary_Btns;
      
      public static const RESOURCE_ClassName_ActivitySecondary_Bmps:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_ActivitySecondary_Bmps;
      
      protected static const COORDINATE_ActivityBtn:Vector.<int> = Vector.<int>([1,7]);
      
      protected static const COLOR_ContextDefault:uint = 4294967295;
      
      protected var FRepeatOper:RepeatOper;
      
      protected var FTweenOperIn:TweenOper;
      
      protected var FTweenOperOut:TweenOper;
      
      protected var FBmp_Pointer:Bitmap;
      
      protected var FUIShortcut:TUIShortcut;
      
      protected var FIsInitialization:Boolean;
      
      protected var FNewActivityModes:TNewActivityModes;
      
      protected var FOnNewActivitySecondary:Function;
      
      public function TWindowNewActivitySecondary(param1:TUIComponent)
      {
         super(param1);
         this.FUIShortcut = new TUIShortcut(this);
         this.FUIShortcut.Capacity = NEW_ACTIVELIST_SECONDARY_TYPE.length;
         this.FNewActivityModes = SLogicsCore.NewActivityModes;
         this.ConstructTweens();
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
         var _loc5_:TAnimationSequence = null;
         var _loc6_:Bitmap = null;
         _loc2_ = int(RESOURCE_ClassName_ActivitySecondary_Bmps.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_ActivitySecondary_Bmps[_loc1_]);
            this.FUIShortcut.NineGridBitmaps[_loc1_] = _loc6_;
            _loc1_++;
         }
         _loc5_ = SResourcesCore.TexturesLobby.GetAnimationSequenceByIdentifiers(CONST_LOBBY.RESOURCESID_Textures_ShortcutEffect,0);
         this.FUIShortcut.Effects = _loc5_;
         this.FBmp_Pointer = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_ActivitySecondary_Bmp_Pointer);
         _loc2_ = int(RESOURCE_ClassName_NewActiveList_Secondary_Btns.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = RESOURCE_ClassName_NewActiveList_Secondary_Btns[_loc1_];
            _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject(_loc3_) as SimpleButton;
            if(_loc4_ == null)
            {
               _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject("Shortcuts_Activity_SubmitBug") as SimpleButton;
            }
            this.FUIShortcut.SetButtonByIndex(_loc4_,_loc1_);
            _loc1_++;
         }
      }
      
      protected function Resources_UILocations() : void
      {
         this.FUIShortcut.CoordinateBtn = COORDINATE_ActivityBtn;
         this.FUIShortcut.Perform_UIDispatch_SecondaryList();
         addChild(this.FBmp_Pointer);
         this.InitializationActivitys();
      }
      
      protected function InitializationActivitys() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(NEW_ACTIVELIST_SECONDARY_TYPE.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUIShortcut.SetFunctionByIndex(this.NewActivitySecondaryOnClick,_loc1_);
            _loc1_++;
         }
      }
      
      protected function UpdateRestActivityState(param1:Vector.<Boolean>, param2:Vector.<Boolean>, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:SimpleButton = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         if(!this.FIsInitialization)
         {
            return;
         }
         if(!this.FUIShortcut.IsInitSecodary)
         {
            return;
         }
         _loc5_ = this.FUIShortcut.Capacity;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = this.FNewActivityModes.getActivityStatus(NEW_ACTIVELIST_SECONDARY_TYPE[_loc4_]);
            _loc6_ = this.FUIShortcut.GetButtonByIndex(_loc4_);
            if(_loc6_.visible != _loc7_)
            {
               _loc6_.visible = _loc7_;
            }
            _loc4_++;
         }
         this.UpdateActivityShortcuts();
      }
      
      protected function UpdateActivityShortcuts() : void
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
            _loc4_ = this.FUIShortcut.GetButtonByIndex(_loc1_);
            _loc5_ = _loc4_.visible;
            if(!_loc5_)
            {
               this.FUIShortcut.SetIsEffectByIndex(_loc5_,_loc1_);
            }
            _loc1_++;
         }
         this.FUIShortcut.ReplaceShortcutsLocation(this);
      }
      
      protected function ComponentsAlign() : void
      {
         if(!this.Visible)
         {
            return;
         }
         this.FBmp_Pointer.x = (this.ShortcutWidth - this.FBmp_Pointer.width - 10) / 2;
         this.FBmp_Pointer.y = this.FUIShortcut.Y - this.FBmp_Pointer.height + 2;
      }
      
      protected function UpdateShortcutEffect() : void
      {
         if(this.FIsInitialization)
         {
            this.FUIShortcut.UpdataEffect();
         }
      }
      
      protected function ProcessorShortcutShowEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:SimpleButton = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:Vector.<uint> = CONST_SHORTCUTS.NEW_ACTIVELIST_SECONDARY_TYPE;
         _loc5_ = _loc6_.indexOf(param1);
         _loc3_ = this.FUIShortcut.GetButtonByIndex(_loc5_);
         if(!_loc3_ || !_loc3_.visible)
         {
            return;
         }
         _loc4_ = this.FUIShortcut.GetIsEffectByIndex(_loc5_);
         if(_loc4_ != param2)
         {
            this.FUIShortcut.SetIsEffectByIndex(param2,_loc5_);
         }
      }
      
      protected function NewActivitySecondaryOnClick(param1:Object, param2:int) : void
      {
         if(this.FOnNewActivitySecondary != null)
         {
            this.FOnNewActivitySecondary(this,param2);
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
      
      public function get OnNewActivitySecondary() : Function
      {
         return this.FOnNewActivitySecondary;
      }
      
      public function set OnNewActivitySecondary(param1:Function) : void
      {
         this.FOnNewActivitySecondary = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
         this.FIsInitialization = true;
      }
      
      public function Show() : void
      {
         this.PerformTweenOperOnStart(null);
      }
      
      public function Hide() : void
      {
         this.PerformTweenOperOnComplete(null);
      }
      
      public function Update() : void
      {
         this.ComponentsAlign();
         this.UpdateShortcutEffect();
      }
      
      public function UpdateShortcutsState(param1:Vector.<Boolean>, param2:Vector.<Boolean>, param3:int) : void
      {
         this.UpdateRestActivityState(param1,param2,param3);
      }
      
      public function ShortcutsSetup(param1:TLobbyShortcutActivityModes, param2:Vector.<Boolean>, param3:Vector.<Boolean>, param4:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:uint = 0;
         var _loc9_:SimpleButton = null;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         if(!this.FIsInitialization)
         {
            return;
         }
         if(!this.FUIShortcut.IsInitSecodary)
         {
            return;
         }
         _loc5_ = int(this.FUIShortcut.Capacity);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc9_.visible = true;
            _loc6_++;
         }
         this.UpdateActivityShortcuts();
      }
      
      public function ShowEffectNotification(param1:uint, param2:Boolean) : void
      {
         this.ProcessorShortcutShowEffect(param1,param2);
      }
      
      public function CheckShortcutsEffect() : Boolean
      {
         return this.FUIShortcut.CheckShortcutsEffect();
      }
   }
}


package Processors.Game.Lobby.Shortcuts.Window
{
   import Components.Shortcuts.*;
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.ActivityMode.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   
   public class TWindowActiveList extends TUIComponent
   {
      
      public static const POSITION_ActiveList:uint = CONST_SHORTCUTS.POSITION_ActiveList;
      
      public static const POSITION_ActiveListSecondary:uint = CONST_SHORTCUTS.POSITION_ActiveListSecondary;
      
      public static const TYPE_ActiveList_RechageCashBack:uint = CONST_SHORTCUTS.TYPE_ActiveList_RechageCashBack;
      
      public static const TYPE_ActiveList_FirstRecharge:uint = CONST_SHORTCUTS.TYPE_ActiveList_FirstRecharge;
      
      public static const TYPE_ActiveList_Recharge:uint = CONST_SHORTCUTS.TYPE_ActiveList_Recharge;
      
      public static const TYPE_ActiveList_Wonderful:uint = CONST_SHORTCUTS.TYPE_ActiveList_Wonderful;
      
      public static const TYPE_ActiveList_ReceivePacks:uint = CONST_SHORTCUTS.TYPE_ActiveList_ReceivePacks;
      
      public static const ACTIVELIST_TYPE:Vector.<uint> = CONST_SHORTCUTS.ACTIVELIST_TYPE;
      
      public static const RESOURCE_ClassName_ActiveList_Btns:Vector.<String> = CONST_SHORTCUTS.RESOURCE_ClassName_ActiveList_Btns;
      
      public static const ACTIVELIST_MAPPING:Vector.<uint> = CONST_SHORTCUTS.ACTIVELIST_MAPPING;
      
      protected static const COORDINATE_ActivityBtn:Vector.<int> = Vector.<int>([1,7]);
      
      protected var FActivityModes:TActivityModes;
      
      protected var FWindowActiveListSecondary:TWindowActiveListSecondary;
      
      protected var FUIShortcut:TUIShortcut;
      
      protected var FBounds:TBounds;
      
      protected var FCoordinate:TCoordinate;
      
      protected var FIsInitialization:Boolean;
      
      protected var FOnActiveList:Function;
      
      protected var FOnActiveListSecondary:Function;
      
      public function TWindowActiveList(param1:TUIComponent, param2:TUIComponent)
      {
         super(param1);
         this.FActivityModes = SLogicsCore.ActivityModes;
         this.FWindowActiveListSecondary = new TWindowActiveListSecondary(param2);
         this.FWindowActiveListSecondary.OnActiveListSecondary = this.ActiveListSecondaryOnClick;
         this.FWindowActiveListSecondary.Visible = false;
         this.FUIShortcut = new TUIShortcut(this);
         this.FUIShortcut.Capacity = ACTIVELIST_TYPE.length;
         this.FUIShortcut.name = "icon_conp_2";
         this.FBounds = new TBounds();
      }
      
      protected function Resources_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:SimpleButton = null;
         var _loc5_:TAnimationSequence = null;
         var _loc6_:TAnimationSequence = null;
         this.FUIShortcut.Bmp_Left = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Left);
         this.FUIShortcut.BmpData_Middle = TUtilityReflection.CreateBitmapDataByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Middle);
         this.FUIShortcut.Bmp_Right = TUtilityReflection.CreateBitmapByDisplayObject(CONST_SHORTCUTS.RESOURCE_ClassName_Activity_Bmp_Right);
         _loc5_ = SResourcesCore.TexturesLobby.GetAnimationSequenceByIdentifiers(CONST_LOBBY.RESOURCESID_Textures_ShortcutEffect,0);
         this.FUIShortcut.Effects = _loc5_;
         _loc6_ = SResourcesCore.TexturesLobby.GetAnimationSequenceByIdentifiers(CONST_LOBBY.RESOURCESID_Textures_SpecialShortcutEffect,0);
         this.FUIShortcut.SpecialEffects = _loc6_;
         _loc2_ = int(ACTIVELIST_TYPE.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = RESOURCE_ClassName_ActiveList_Btns[_loc1_];
            _loc4_ = TUtilityReflection.CreateSimpleButtonByDisplayObject(_loc3_) as SimpleButton;
            this.FUIShortcut.SetButtonByIndex(_loc4_,_loc1_);
            _loc4_.visible = false;
            _loc1_++;
         }
      }
      
      protected function Resources_UILocations() : void
      {
         this.FUIShortcut.CoordinateBtn = COORDINATE_ActivityBtn;
         this.FUIShortcut.Perform_UIDispatch();
         this.InitializationActivitys();
      }
      
      protected function InitializationActivitys() : void
      {
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListOnClick,TYPE_ActiveList_RechageCashBack);
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListOnClick,TYPE_ActiveList_FirstRecharge);
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListOnClick,TYPE_ActiveList_Recharge);
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListOnClick,TYPE_ActiveList_Wonderful);
         this.FUIShortcut.SetFunctionByIndex(this.ActiveListOnClick,TYPE_ActiveList_ReceivePacks);
         this.FUIShortcut.OnBtnOver = this.ActiveListOnOver;
         this.FWindowActiveListSecondary.addEventListener(MouseEvent.ROLL_OVER,this.WindowActiveListSecondaryOnOver);
         this.addEventListener(MouseEvent.ROLL_OUT,this.WindowActiveListOnOut);
         this.FWindowActiveListSecondary.addEventListener(MouseEvent.ROLL_OUT,this.WindowActiveListSecondaryOnOut);
      }
      
      public function ProcessorOpenStatusNotification() : void
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
         _loc2_ = int(this.FUIShortcut.Capacity);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivityModes.GetActivityIconIsOn(ACTIVELIST_MAPPING[_loc1_] + 1);
            _loc4_ = this.FUIShortcut.GetButtonByIndex(_loc1_);
            if(_loc4_.visible != _loc3_)
            {
               _loc4_.visible = _loc3_;
            }
            _loc1_++;
         }
         this.UpdateActiveListShortcuts();
         this.FWindowActiveListSecondary.OpenStatusNotification();
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
         var _loc1_:SimpleButton = null;
         if(!this.Visible)
         {
            return;
         }
         _loc1_ = this.FUIShortcut.GetButtonByIndex(TYPE_ActiveList_ReceivePacks);
         if(!_loc1_.visible)
         {
            return;
         }
         this.FCoordinate = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc1_);
         this.FCoordinate.X += this.FUIShortcut.BmpData_Middle.width / 2;
         this.FCoordinate.Y += this.Height - 18;
         if(this.FWindowActiveListSecondary.ShortcutWidth > 0)
         {
            this.FWindowActiveListSecondary.X = this.FCoordinate.X - this.FWindowActiveListSecondary.ShortcutWidth / 2;
            this.FWindowActiveListSecondary.Y = this.FCoordinate.Y;
         }
         else if(this.FWindowActiveListSecondary.Visible)
         {
            this.FWindowActiveListSecondary.Hide();
         }
      }
      
      protected function UpdateShortcutEffect() : void
      {
         if(this.FUIShortcut.IsInitialization)
         {
            this.FUIShortcut.UpdataEffect();
         }
      }
      
      protected function ProcessorShortcutShowSpecialEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:SimpleButton = null;
         var _loc4_:Boolean = false;
         _loc3_ = this.FUIShortcut.GetButtonByIndex(param1);
         if(!_loc3_.visible)
         {
            return;
         }
         _loc4_ = this.FUIShortcut.GetIsSpecialEffectByIndex(param1);
         if(_loc4_ != param2)
         {
            this.FUIShortcut.SetIsSpecialEffectByIndex(param2,param1);
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
      
      protected function ActiveListOnClick(param1:Object, param2:int) : void
      {
         var _loc3_:Boolean = false;
         if(param2 == TYPE_ActiveList_ReceivePacks)
         {
            _loc3_ = this.FWindowActiveListSecondary.Visible;
            if(!_loc3_)
            {
               this.FWindowActiveListSecondary.Hide();
            }
            else
            {
               this.FWindowActiveListSecondary.Show();
            }
            return;
         }
         if(this.FOnActiveList != null)
         {
            this.FOnActiveList(this,param2);
         }
      }
      
      protected function ActiveListOnOver(param1:Object, param2:int) : void
      {
         if(param2 == TYPE_ActiveList_ReceivePacks)
         {
            this.FWindowActiveListSecondary.Show();
            return;
         }
         this.FWindowActiveListSecondary.Hide();
      }
      
      protected function ActiveListSecondaryOnClick(param1:Object, param2:int) : void
      {
         if(this.FOnActiveListSecondary != null)
         {
            this.FOnActiveListSecondary(this,param2);
         }
      }
      
      protected function WindowActiveListOnOut(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:TCoordinate = null;
         _loc3_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(this.FWindowActiveListSecondary);
         this.FBounds.Assign(_loc3_);
         this.FBounds.Width = this.FWindowActiveListSecondary.ShortcutWidth;
         this.FBounds.Height = this.FWindowActiveListSecondary.Height + 20;
         this.FBounds.Y -= 20;
         _loc2_ = TUtilityCartisian.BoundsContainsCoordinate(this.FBounds,FUICore.MouseCoordinate);
         if(!_loc2_)
         {
            this.FWindowActiveListSecondary.Hide();
         }
      }
      
      protected function WindowActiveListSecondaryOnOver(param1:MouseEvent) : void
      {
         this.FWindowActiveListSecondary.Show();
      }
      
      protected function WindowActiveListSecondaryOnOut(param1:MouseEvent) : void
      {
         this.FWindowActiveListSecondary.Hide();
      }
      
      public function get ShortcutWidth() : int
      {
         return this.FUIShortcut.Bounds.Width;
      }
      
      public function get OnActiveList() : Function
      {
         return this.FOnActiveList;
      }
      
      public function set OnActiveList(param1:Function) : void
      {
         this.FOnActiveList = param1;
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
         return this.FWindowActiveListSecondary.HintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FWindowActiveListSecondary.HintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FWindowActiveListSecondary.HintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FWindowActiveListSecondary.HintOnOut = param1;
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
         this.Resources_UILocations();
         this.FWindowActiveListSecondary.Perform_UIDispatch();
         this.FIsInitialization = true;
      }
      
      public function Update() : void
      {
         this.ComponentsAlign();
         this.FWindowActiveListSecondary.Update();
         this.UpdateShortcutEffect();
      }
      
      public function OpenStatusNotification() : void
      {
         this.ProcessorOpenStatusNotification();
      }
      
      public function ShowSpecialNotification(param1:uint, param2:uint, param3:Boolean) : void
      {
         switch(param1)
         {
            case POSITION_ActiveList:
               this.ProcessorShortcutShowSpecialEffect(param2,param3);
         }
      }
      
      public function ShowEffectNotification(param1:uint, param2:uint, param3:Boolean) : void
      {
         switch(param1)
         {
            case POSITION_ActiveList:
               this.ProcessorShortcutShowEffect(param2,param3);
               break;
            case POSITION_ActiveListSecondary:
               this.FWindowActiveListSecondary.ShowEffectNotification(param2,param3);
         }
      }
   }
}

